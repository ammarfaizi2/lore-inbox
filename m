Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271522AbRIFRgR>; Thu, 6 Sep 2001 13:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271557AbRIFRgH>; Thu, 6 Sep 2001 13:36:07 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40951
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S271522AbRIFRfx>; Thu, 6 Sep 2001 13:35:53 -0400
Date: Thu, 6 Sep 2001 10:35:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kurt Garloff <garloff@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010906103553.F29607@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Kurt Garloff <garloff@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20010906124700Z16067-32383+3773@humbolt.nl.linux.org> <Pine.LNX.4.33L.0109061002050.31200-100000@imladris.rielhome.conectiva> <20010906151827.F21793@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010906151827.F21793@gum01m.etpnet.phys.tue.nl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 03:18:27PM +0200, Kurt Garloff wrote:
> On Thu, Sep 06, 2001 at 10:03:03AM -0300, Rik van Riel wrote:
> > On Thu, 6 Sep 2001, Daniel Phillips wrote:
> > > On September 6, 2001 02:32 pm, Rik van Riel wrote:
> > > > Two words:  "IO clustering".
> > >
> > > Yes, *after* the IO queue is fully loaded that makes sense.  Leaving it
> > > partly or fully idle while waiting for it to load up makes no sense at all.
> > >
> > > IO clustering will happen naturally after the queue loads up.
> > 
> > Exactly, so we need to give the queue some time to load
> > up, right ?
> 
> Just use two limits:
> * Time: After some time (say two seconds), we can always afford to write it
>   out 
> * Queue filling: After it has a certain size, it's worth doing a writing.
> 

Correct me if I'm wrong, but aren't these two settings tunable in bdflush?
If not, then how exactly does bdflush interact with this?

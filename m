Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271401AbRIFQjq>; Thu, 6 Sep 2001 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271388AbRIFQjg>; Thu, 6 Sep 2001 12:39:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:262 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271349AbRIFQjT>; Thu, 6 Sep 2001 12:39:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Kurt Garloff <garloff@suse.de>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 18:45:52 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906124700Z16067-32383+3773@humbolt.nl.linux.org> <Pine.LNX.4.33L.0109061002050.31200-100000@imladris.rielhome.conectiva> <20010906151827.F21793@gum01m.etpnet.phys.tue.nl>
In-Reply-To: <20010906151827.F21793@gum01m.etpnet.phys.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906163937Z16125-26183+11@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 03:18 pm, Kurt Garloff wrote:
> On Thu, Sep 06, 2001 at 10:03:03AM -0300, Rik van Riel wrote:
> > On Thu, 6 Sep 2001, Daniel Phillips wrote:
> > > On September 6, 2001 02:32 pm, Rik van Riel wrote:
> > > > Two words:  "IO clustering".
> > >
> > > Yes, *after* the IO queue is fully loaded that makes sense.  Leaving it
> > > partly or fully idle while waiting for it to load up makes no sense at 
all.
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

Err, not quite the whole story.  It is *never* right to leave the disk 
sitting idle while there are dirty, writable IO buffers.

--
Daniel

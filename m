Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTKQUHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTKQUHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:07:10 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:48514
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262181AbTKQUHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:07:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Stan Bubrouski <stan@ccs.neu.edu>, Rik van Riel <riel@redhat.com>
Subject: Re: Bad interactivity with 2.6-test9
Date: Tue, 18 Nov 2003 07:06:58 +1100
User-Agent: KMail/1.5.3
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <Pine.LNX.4.44.0311171354050.27370-100000@chimarrao.boston.redhat.com> <1069099418.23780.2.camel@duergar>
In-Reply-To: <1069099418.23780.2.camel@duergar>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311180706.58225.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003 07:03 am, Stan Bubrouski wrote:
> On Mon, 2003-11-17 at 13:54, Rik van Riel wrote:
> > On Sun, 16 Nov 2003, Stan Bubrouski wrote:
> > > When I start watching a video under mplayer and have something like
> > > spamassassin doing a sa-learn in an x-term if I start the sa-learn
> > > before mplayer and then play a video, the sa-learn makes  no  progress
> > > until I switch away from mplayer (playing full screen).  After which
> > > sa-learn continues to filter through messages much faster, and even
> > > while mplayer is going is still progressing much faster than before I
> > > switched away from mplayer the first time.
> > >
> > > Very odd.  Con anyone ideas?
> >
> > Looks like scheduler starvation.  Con ?
>
> Seems like it.  I'll do some testing later to see exactly how
> consistently I can reproduce this.  I have noticed this numerous times
> all with -test9.

Usual checks. See if it happened with test6,7,8 as well as 9.
Do `vmstat 1' output to file and `top -d 1' output to file. They can tell if 
it's a dynamic priority related scheduler starvation issue.

Con


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSG1VKH>; Sun, 28 Jul 2002 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSG1VKG>; Sun, 28 Jul 2002 17:10:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:57556 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317331AbSG1VKG>;
	Sun, 28 Jul 2002 17:10:06 -0400
Date: Sun, 28 Jul 2002 23:13:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
Message-ID: <20020728211323.GB26925@win.tue.nl>
References: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <20020727235726.GB26742@win.tue.nl> <20020728024739.GA28873@kroah.com> <20020728155626.GC26862@win.tue.nl> <20020728185310.GC5767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728185310.GC5767@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 11:53:10AM -0700, Greg KH wrote:

> > I reported an oops at shutdown and provided the trivial fix.
> > It is the the standard kernel since 2.5.26, I think.
> 
> That patch should be in the latest kernel, thanks.

Yes, since 2.5.26.

> Let me know if you are still having that problem in .29

No, I fixed that problem. But, as I told you:

> > But there are still other oopses at shutdown for 2.5.27.
> > 
> > For 2.5.29 I reported
> > "> I booted 2.5.29 earlier this evening and was greeted by
> >  > kernel BUG at transport.c: 351 and
> >  > kernel BUG at scsiglue.c: 150.
> >  > (And the usb-storage module now hangs initializing; rmmod fails,
> >  > reboot is necessary.)"

[Maybe I forgot to tell you; I am a mathematician; tend to be
fairly precise; thus, the above precisely describes the state
of my knowledge yesterday evening: in the category "USB-induced
oopses at reboot" one bug was fixed in 2.5.26; there are further
such bugs still present in 2.5.27; concerning 2.5.29, it does not
get far enough to decide: the usb-storage module hangs initializing.]

Andries


(Concerning this BUG_ON in transport.c: it should be commented out
for the moment. First of all, nothing is wrong, I think, and secondly,
we know already with certainty that it will happen, so nothing is learnt.
Matt simultaneously came with some SCSI patches. More or less reasonable,
although discussion was possible. But these were not applied in 2.5.29.
If and when these or similar patches have been applied to the SCSI code
one may consider enabling this BUG_ON again.)
(I have not yet looked at the BUG at scsiglue.c: 150.)

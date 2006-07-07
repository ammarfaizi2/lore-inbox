Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWGGONz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWGGONz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGGONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:13:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60944 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751197AbWGGONp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:13:45 -0400
Date: Fri, 7 Jul 2006 14:10:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-ID: <20060707141030.GC4239@ucw.cz>
References: <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44AB3E4C.2000407@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-07-06 00:21:32, Bill Davidsen wrote:
> Benny Amorsen wrote:
> >>>>>>"DC" == Diego Calleja <diegocg@gmail.com> writes:
> >
> >DC> El Mon, 03 Jul 2006 15:46:55 -0600, "Jeff V. Merkey"
> >DC> <jmerkey@wolfmountaingroup.com> escribió:
> >
> >>>Add a salvagable file system to ext4, i.e. when a 
> >>>file is deleted,
> >>>you just rename it and move it to a directory called 
> >>>DELETED.SAV
> >>>and recycle the files as people allocate new ones. 
> >>>Easy to do
> >>>(internal "mv" of
> >
> >
> >DC> Easily doable in userspace, why bother with kernel 
> >programming
> >
> >In userspace you can't automatically delete the files 
> >when the space
> >becomes needed. The LD_PRELOAD/glibc methods also have 
> >the
> >disadvantage of having to figure out where a file goes 
> >when it's
> >deleted, depending on which device it happens to reside 
> >on. Demanding
> >read access to /proc/mounts just to do rm could cause 
> >problems.
> >
> >Userspace has had 10 years to invent a good solution. 
> >If it was so
> >easy, it would probably have been done.
> >
> Actually, if it were so important it WOULD have been 
> done. I suspect that the issue is not lack of a good 

It *was* done. mc supports undelete on ext2. Unfortunately ext3 broke
that :-(.
							Pavel
-- 
Thanks for all the (sleeping) penguins.

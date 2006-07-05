Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWGEESp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWGEESp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWGEESp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:18:45 -0400
Received: from mail.tmr.com ([64.65.253.246]:33433 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932392AbWGEESo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:18:44 -0400
Message-ID: <44AB3E4C.2000407@tmr.com>
Date: Wed, 05 Jul 2006 00:21:32 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk>
In-Reply-To: <m3r711u3yk.fsf@ursa.amorsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benny Amorsen wrote:
>>>>>> "DC" == Diego Calleja <diegocg@gmail.com> writes:
> 
> DC> El Mon, 03 Jul 2006 15:46:55 -0600, "Jeff V. Merkey"
> DC> <jmerkey@wolfmountaingroup.com> escribió:
> 
>>> Add a salvagable file system to ext4, i.e. when a file is deleted,
>>> you just rename it and move it to a directory called DELETED.SAV
>>> and recycle the files as people allocate new ones. Easy to do
>>> (internal "mv" of
> 
> 
> DC> Easily doable in userspace, why bother with kernel programming
> 
> In userspace you can't automatically delete the files when the space
> becomes needed. The LD_PRELOAD/glibc methods also have the
> disadvantage of having to figure out where a file goes when it's
> deleted, depending on which device it happens to reside on. Demanding
> read access to /proc/mounts just to do rm could cause problems.
> 
> Userspace has had 10 years to invent a good solution. If it was so
> easy, it would probably have been done.
> 
Actually, if it were so important it WOULD have been done. I suspect 
that the issue is not lack of a good solution, but lack of a good 
problem. The behavior you propose requires a lot of kernel cleverness, 
including make the inodes seem to go away, so the count is "right" for 
what the user sees.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSA2OMM>; Tue, 29 Jan 2002 09:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSA2OMD>; Tue, 29 Jan 2002 09:12:03 -0500
Received: from pc-80-195-34-66-ed.blueyonder.co.uk ([80.195.34.66]:49536 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S288854AbSA2OLv>; Tue, 29 Jan 2002 09:11:51 -0500
Date: Tue, 29 Jan 2002 14:11:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: frode <frode@freenix.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: OOPS: kernel BUG at transaction.c:1857 on 2.4.17 while rm'ing 700mb file on ext3 partition.
Message-ID: <20020129141146.B1873@redhat.com>
In-Reply-To: <3C502E3A.9070909@freenix.no> <20020124191927.A9564@redhat.com> <3C509067.20108@freenix.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C509067.20108@freenix.no>; from frode@freenix.no on Thu, Jan 24, 2002 at 11:53:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 24, 2002 at 11:53:27PM +0100, frode wrote:

> >>I got the following error while rm'ing a 700mb file from an ext3 partition:
> >>Assertion failure in journal_unmap_buffer() at transaction.c:1857:
> >>"transaction == journal->j_running_transaction"
> > Hmm --- this is not one I think I've ever seen before.
 
> OK, I rebooted and gzip'ed the NVdriver in /lib/modules... to make sure the 
> module doesn't load (lsmod now says my kernel isn't tainted). I'll try using the 
> plain 'nv' driver shipped with XFree instead for a while. I tried making another 
> 700mb iso image and fool around with it (loopback mount it, umount it, then rm 
> it) but couldn't trigger anything - but I just spent five minutes trying.

Have you been able to reproduce any problems yet?

> As I mentioned I have had quite a few oopses lately, most of them regarding 
> paging etc. (but I'm no kernel expert). See for example
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101096234600708&w=2
> and
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101128528029736&w=2

iput() crash; page list crash; jbd transaction crash.  These look
perfectly consistent with random memory corruption.
> 
> I'm running linux on an old p100 as well but don't see any problems, so as you 
> say I suspected a hardware problem. I ran MemTest86 for about half an hour 

Try leaving it running overnight --- half an hour is very little time
for a proper memory test.

Cheers,
 Stephen

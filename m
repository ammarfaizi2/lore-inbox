Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130511AbQLTV2A>; Wed, 20 Dec 2000 16:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLTV1u>; Wed, 20 Dec 2000 16:27:50 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:12037 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130138AbQLTV1l> convert rfc822-to-8bit; Wed, 20 Dec 2000 16:27:41 -0500
Date: Wed, 20 Dec 2000 15:56:27 -0500
From: Chris Mason <mason@suse.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.2.18] VM: do_try_to_free_pages failed
Message-ID: <185060000.977345787@coffee>
In-Reply-To: <20001220130259.A9659@emma1.emma.line.org>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, December 20, 2000 13:03:00 +0100 Matthias Andree
<matthias.andree@stud.uni-dortmund.de> wrote:

> Last night, one of your production machines got wedged, I caught a lot
> of kernel: VM: do_try_to_free_pages failed for ... for a whole range of
> processes, among them ypbind, klogd, syslogd, xntpd, cron, nscd, X,
> master (Postfix super daemon), pvmd3, K applications and so on, I was
> unable to log in via ssh, someone on-site has finally reset that machine
> this noon to bring it back online.
> > How can I get rid of those do_try_to_free_pages lockups? That box
> exports root file systems for some SparcStation 2 that are used as X
> terminals, so it's pretty important I keep that box running.
> > Should I try the most recent 2.2.19-pre?
> > The machine is a pentium-MMX with 64 MB RAM with a kernel 2.2.18 that
> has these patches/updated drivers (none VM related AFAICS):
> > IDE 2.2.18.1209
> I²C 2.5.4
> LM_Sensors 2.5.4
> DC390 2.0e7
> ReiserFS 3.5.28
> 
If you still see the problem with Andrea's VM global patch (you can get
just that one patch from ftp.kernel.org/pub/people/andrea), try cutting
JOURNAL_MAX_BATCH in half.  This will lower the amount of memory reiserfs
is willing to pin in one transaction...

-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

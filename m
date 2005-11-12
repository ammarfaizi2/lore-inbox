Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVKLVL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVKLVL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVKLVL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:11:59 -0500
Received: from cerqueira.net ([195.23.98.191]:49124 "HELO home.cerqueira.org")
	by vger.kernel.org with SMTP id S964811AbVKLVL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:11:59 -0500
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue
	buffer failed: Bad address" (2 Nov 2005, 11 Nov 2005)
From: Ricardo Cerqueira <rmcc@isp.novis.pt>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Michael Krufky <mkrufky@m1k.net>, Junichi Uekawa <dancer@netfort.gr.jp>,
       debian-amd64@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <878xvv2rk2.dancerj%dancer@netfort.gr.jp>
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp>
	 <87wtjg5gh2.dancerj%dancer@netfort.gr.jp> <4373D087.5050908@linuxtv.org>
	 <87psp859sd.dancerj%dancer@netfort.gr.jp> <43740F06.6030504@m1k.net>
	 <87y83vl780.dancerj%dancer@netfort.gr.jp>
	 <87ek5nb9ec.dancerj%dancer@netfort.gr.jp>
	 <878xvv2rk2.dancerj%dancer@netfort.gr.jp>
Content-Type: text/plain
Organization: Novis Telecom - ISP
Date: Sat, 12 Nov 2005 21:11:19 +0000
Message-Id: <1131829879.3357.7.camel@frolic>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again;

	We just got confirmation from someone at freenode that this problem
exists with other chips as well (saa7134, in this case), so it's not
chip dependent. It seems to be confined to x86_64 and 2.6.15, though.

On Fri, 2005-11-11 at 23:21 +0900, Junichi Uekawa wrote:
> Hi,
> 
> > That was wrong; I re-tested it and it looks like
> > 6e9d6b8ee4e0c37d3952256e6472c57490d6780d was a bad one.
> > 2.6.14 (741b2252a5e14d6c60a913c77a6099abe73a854a) is functional.
> > 
> > $ git-bisect start
> > $ git-bisect bad 6e9d6b8ee4e0c37d3952256e6472c57490d6780d
> > $ git-bisect good 741b2252a5e14d6c60a913c77a6099abe73a854a
> > Bisecting: 721 revisions left to test after this
> 
> After that I tried:
> $ git-bisect bad
> Bisecting: 1966 revisions left to test after this
> [23fd07750a789a66fe88cf173d52a18f1a387da4] Merge ../linux-2.6 by hand
> 
> I'm not quite sure why the following happened.
> 6e9d6b8ee4e0c37d3952256e6472c57490d6780d 30 Oct is broken
> 741b2252a5e14d6c60a913c77a6099abe73a854a 27 Oct is functional
> 6e6ece5dc6022e8086c565498d23511bbceda811 10 Nov is broken 
> 23fd07750a789a66fe88cf173d52a18f1a387da4 31 Oct -- does not boot due to USB/PCI quirks
> 
> Maybe I'm doing something wrong.
> 
> 
> 
> $ git-bisect log
> git-bisect start
> # bad: [6e9d6b8ee4e0c37d3952256e6472c57490d6780d] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev
> git-bisect bad 6e9d6b8ee4e0c37d3952256e6472c57490d6780d
> # good: [741b2252a5e14d6c60a913c77a6099abe73a854a] Linux v2.6.14
> git-bisect good 741b2252a5e14d6c60a913c77a6099abe73a854a
> # bad: [6e6ece5dc6022e8086c565498d23511bbceda811] PCI: fix for Toshiba ohci1394 quirk
> git-bisect bad 6e6ece5dc6022e8086c565498d23511bbceda811
> 
> 
> 
> regards,
> 	junichi
> 
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
-- 
Ricardo Cerqueira
ISP - Service & Platform Architectures
Novis Telecom -  Estrada da Outurela, 118 A / 2795-606 Carnaxide /
Portugal
Tel: +351 2 1010 4686 - Fax: +351 2 1012 9248


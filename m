Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbRBXCnq>; Fri, 23 Feb 2001 21:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbRBXCni>; Fri, 23 Feb 2001 21:43:38 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:56068 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129577AbRBXCn3>; Fri, 23 Feb 2001 21:43:29 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200102240244.SAA03481@cx518206-b.irvn1.occa.home.com>
Subject: Re: loop-6 patch and 2.4.2
To: sxking@uswest.net
Date: Fri, 23 Feb 2001 18:44:01 -0800 (PST)
Cc: mhaque@haque.net ( Mohammad A. Haque), linux-kernel@vger.kernel.org ( )
Reply-To: barryn@pobox.com
In-Reply-To: <01022311194600.00869@rigel> from "Steven King" at Feb 23, 2001 11:19:46 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven King wrote:
> On Friday 23 February 2001 10:50, 	Mohammad A. Haque wrote:
> > Is anyone else using 2.4.2 patched with loop-6? Does load goto about 1
> > and stay there even though mounting things via loop seem to work fine?
> 
>   Yes, and with 2 mounts the load avg goes ~2; after umounting, it goes back 
> to normal levels.

You can observe with ps that each thread for each mounted loop device
increases the load by 1; here's the output from "ps ax | fgrep loop" on my
Dell Inspiron 5000e:

   13 ?        DW<    0:28 [loop1]
  115 ?        DW<    0:57 [loop0]
  116 ?        DW<    0:58 [loop2]
 2816 pts/4    S      0:00 fgrep loop

Since I have 3 image files mounted, that means my Inspiron 5000e has a load
of 3 when it's idle... ;)

-Barry K. Nathan <barryn@pobox.com>

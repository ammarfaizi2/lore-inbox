Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132284AbQLNSeB>; Thu, 14 Dec 2000 13:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131960AbQLNSds>; Thu, 14 Dec 2000 13:33:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35332 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131841AbQLNSd3>; Thu, 14 Dec 2000 13:33:29 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 14 Dec 2000 18:05:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <200012141359.eBEDxFs46530@aslan.scsiguy.com> from "Justin T. Gibbs" at Dec 14, 2000 06:59:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146ckd-0000L1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I figured as much.  I will test for the #define, stash it in a #define
> unique within my namespace, and #define it back in hosts.c should my
> local define exist.

I think its pretty much x86 only that has the define problem. For 2.2 its 
stuck and one or two folks depend on it. For 2.4 I cannot see why we don't 
change the inline function to be current() not get_current() thereby cleaning
up the struct problem you see.

On the other platforms current is general a gcc register global and so wont
interfere with struct namespace

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

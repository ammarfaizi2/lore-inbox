Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPHAe>; Sat, 16 Dec 2000 02:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLPHAZ>; Sat, 16 Dec 2000 02:00:25 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:15044 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129183AbQLPHAK>; Sat, 16 Dec 2000 02:00:10 -0500
Message-ID: <3A3B0CBD.1AAA99C2@uow.edu.au>
Date: Sat, 16 Dec 2000 17:33:33 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: barryn@pobox.com
CC: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test13pre2 - netfilter modiles compile failure
In-Reply-To: <3A3AF5F5.BDC853F4@haque.net> from "Mohammad A. Haque" at Dec 15, 2000 11:56:21 PM <200012160552.VAA27106@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" wrote:
> 
> I got the same error with the ipchains-compatible netfilter compiled as
> modules.

This works for me:

--- linux-2.4.0-test13-pre2/net/ipv4/netfilter/Makefile	Sat Dec 16 14:23:48 2000
+++ linux-akpm/net/ipv4/netfilter/Makefile	Sat Dec 16 15:01:23 2000
@@ -61,6 +61,3 @@
 
 ipchains.o: $(ipchains-objs)
 	$(LD) -r -o $@ $(ipchains-objs)
-
-ip_nf_compat.o: $(ip_nf_compat-objs)
-	$(LD) -r -o $@ $(ip_nf_compat-objs)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268592AbRGZRyH>; Thu, 26 Jul 2001 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268596AbRGZRx5>; Thu, 26 Jul 2001 13:53:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54031 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268592AbRGZRxl>; Thu, 26 Jul 2001 13:53:41 -0400
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
To: vandrove@vc.cvut.cz (Petr Vandrovec)
Date: Thu, 26 Jul 2001 18:52:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20010726194800.A32053@vana.vc.cvut.cz> from "Petr Vandrovec" at Jul 26, 2001 07:48:00 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PpJg-0004D5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>   following is patch which was needed for compiling 2.4.7-ac1
> on box equipped with 'gcc version 3.0.1 20010721 (Debian prerelease)'.
> As I did not see such complaint yet - here it is.
>   If you think that gcc is too lazy on inlining (I think so...),
> tell me and I'll complain to gcc team instead of here.

Fix gcc. We use extern inline to say 'must be inlined' and that was the
semantic it used to have. Some of our inlines will not work if the compiler
uninlines them.

Alan

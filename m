Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTDZEFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 00:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTDZEFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 00:05:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264606AbTDZEFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 00:05:19 -0400
Message-ID: <3EAA0850.8050600@pobox.com>
Date: Sat, 26 Apr 2003 00:17:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] irqreturn_t unsignedness
Content-Type: multipart/mixed;
 boundary="------------080203040004080003080005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080203040004080003080005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080203040004080003080005
Content-Type: text/plain;
 name="irq-return-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq-return-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/irq-return-2.5

This will update the following files:

 include/linux/interrupt.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/04/25 1.1252)
   s/int/unsigned int/ for irqreturn_t definition.
   
   Pragmatic change.  Would prefer to make it now rather than later.
   Though sign-extension problems are unlikely, I prefer 'unsigned int'
   because it occasionally generates better code, and 'int' occasionally
   generates sub-optimal code (because the compiler cannot rule out
   negative values during optimization).
   
   Better still would be to indicate the variable's true range
   via _Bool:  zero, and non-zero, but I did not make that change
   here.


--------------080203040004080003080005--


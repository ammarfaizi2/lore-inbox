Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVJQXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVJQXpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVJQXpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:45:39 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:24847 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751404AbVJQXpi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:45:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=T266UFJ9/G0a3eR1z9rmi94ie3D9D527WVL7NBaMhfSg3gFnFPRe+kfVFnys9vcwyEQGBTdy1EyWrS34inyD18itnTP5OURbxkHrsWOAIGOWZ12mz8GITFFoa9dMLq5S479257iwqpb5G27yljhnVzyjuou/q2TOtJejvuJAmx4=
Message-ID: <cc9bf44d0510171645t78aaa572h6b7a8521f2d76939@mail.gmail.com>
Date: Tue, 18 Oct 2005 09:15:36 +0930
From: Paul Schulz <pschulz01@gmail.com>
Reply-To: paul@mawsonlakes.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13] pxa-regs: Typo in ARM pxa register definitions.
Cc: trivial@rustcorp.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
The following trivial patch is to fix what looks like a typo in the PXA register
definitions. The correction comes directly from the definition in the
Intel Documentation.

   http://www.intel.com/design/pca/applicationsprocessors/manuals/278693.htm
   Intel(R) PXA 255 Processor - Developers Manual - Jan 2004 - Page 12-33

Neither 'UDCCS_IO_ROF' or 'UDCCS_IO_DME' are currently used elseware
in the main code (from grep of tree)... The current definitions have been
in the code since at lease 2.4.7.

 Paul Schulz  <paul@mawsonlakes.org>
 ---
 diff -Nuar linux-2.6.13.orig/include/asm-arm/arch-pxa/pxa-regs.h
linux-2.6.13/include/asm-arm/arch-pxa/pxa-regs.h
 --- linux-2.6.13.orig/include/asm-arm/arch-pxa/pxa-regs.h      
2005-08-31 11:40:22.000000000 +0930
 +++ linux-2.6.13/include/asm-arm/arch-pxa/pxa-regs.h    2005-10-13
15:04:52.141864488 +0930
 @@ -652,7 +652,7 @@

  #define UDCCS_IO_RFS   (1 << 0)        /* Receive FIFO service */
  #define UDCCS_IO_RPC   (1 << 1)        /* Receive packet complete */
 -#define UDCCS_IO_ROF   (1 << 3)        /* Receive overflow */
 +#define UDCCS_IO_ROF   (1 << 2)        /* Receive overflow */
  #define UDCCS_IO_DME   (1 << 3)        /* DMA enable */
  #define UDCCS_IO_RNE   (1 << 6)        /* Receive FIFO not empty */
  #define UDCCS_IO_RSP   (1 << 7)        /* Receive short packet */


Signed-off-by: Paul Schulz <paul@mawsonlakes.org>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUFGFnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUFGFnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 01:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUFGFnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 01:43:01 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:20420 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264288AbUFGFm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 01:42:56 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Mikael Starvik'" <mikael.starvik@axis.com>,
       "'Jeff Garzik'" <jgarzik@pobox.com>, "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] CRIS architecture update
Date: Mon, 7 Jun 2004 07:42:18 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668640C44@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668D47E56@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It will probably fail on devices needing write access because
>e100_dma_begin() always passes e100_read_command as
>argument to e100_start_dma().

e100_read_command is a variable that is either 1 for reads
or 0 for writes. This variable is set in e100_dma_write and
e100_dma_read. As long as the framework calls dma_write or 
dma_read before it calls dma_begin it will work just fine.

The driver has been tested with a ext2 filesystem on a disk 
(and the files are still there after a sync and reboot).

/Mikael


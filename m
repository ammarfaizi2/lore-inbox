Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUJYO1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUJYO1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUJYO1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:27:44 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:2716 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261827AbUJYO05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:26:57 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]Uncompressing Linux... Out of memory: fixed by increased HEAP_SIZE
Date: Mon, 25 Oct 2004 16:28:20 +0200
User-Agent: KMail/1.6.2
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410251628.20505.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

booting newest 2.6.9 experimental kernels, I frequently encountered 
"Uncompressing Linux... Out of memory --System halted"
In some mail archive I found the (obvious ;-) solution: Increase HEAP_SIZE.

Here in line 122 of arch/i386/boot/compressed/misc.c this
	#define HEAP_SIZE             0x4000
instead of 
	#define HEAP_SIZE             0x3000
made 2.6.9-mm1-RT-U10.3 boot again.

0x3400 or 03800 might also do it, haven't checked.

Best,
Karsten

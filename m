Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSELNNN>; Sun, 12 May 2002 09:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSELNNM>; Sun, 12 May 2002 09:13:12 -0400
Received: from samar.sasken.com ([164.164.56.2]:63966 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S313132AbSELNNJ>;
	Sun, 12 May 2002 09:13:09 -0400
Date: Sun, 12 May 2002 18:44:16 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel panic Problem 
In-Reply-To: <20020512125546Z313120-22652+4161@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0205121836420.11151-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am trying to add a few new sytem calls to my linux kernel through
modules.

After I install the module using insmod, some times, the kernel panics
with the message -

	"Attempted to kill idle task - not syncing"

Some times, I am getting the message -

	"Attempted to kill Interrupt handler - not syncing"

Could someone tell me what kind of problem this is??

I am wondering if this is a problem with synchronization in kernel. I am
disabling and enabling interrupts before updating the sys_call_table as
follows:

	save_flags();
	cli();
	.
	.
	.
	sti();
	restore_flags();

Could there be some problem with the above sequence? Could some one
suggest me the correct way of disabling interrupts before updating
sys_call_table.

Thank you in advance.

regards
Madhavi.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136540AbRD3Wnb>; Mon, 30 Apr 2001 18:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136538AbRD3WnW>; Mon, 30 Apr 2001 18:43:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136537AbRD3WnO>; Mon, 30 Apr 2001 18:43:14 -0400
Subject: Re: BUG: USB/Reboot
To: swarm@warpcore.provalue.net (Collectively Unconscious)
Date: Mon, 30 Apr 2001 23:46:41 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104250735390.28677-100000@warpcore.provalue.net> from "Collectively Unconscious" at Apr 25, 2001 07:37:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uMRI-0000Zj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not familiar with that option, where would I be setting it? Or even
> better, where is it documented?

Documentation/kernel-parameters.txt

and arch/i386/kernel/boot.c

                switch (*str) {
                case 'w': /* "warm" reboot (no memory testing etc) */
                        reboot_mode = 0x1234;
                        break;
                case 'c': /* "cold" reboot (with memory testing etc) */
                        reboot_mode = 0x0;
                        break;
                case 'b': /* "bios" reboot by jumping through the BIOS */
                        reboot_thru_bios = 1;
			break;
                case 'h': /* "hard" reboot by toggling RESET and/or crashing th
                        reboot_thru_bios = 0;
                        break;

Alan 


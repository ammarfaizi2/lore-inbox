Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbTADNiM>; Sat, 4 Jan 2003 08:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbTADNiM>; Sat, 4 Jan 2003 08:38:12 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:62917 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S266903AbTADNiM>; Sat, 4 Jan 2003 08:38:12 -0500
Date: Sat, 4 Jan 2003 14:46:44 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Ranjeet Shetye <ranjeet.shetye@zultys.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [STUPID] Best looking code to transfer to a t-shirt
In-Reply-To: <001901c2b387$1ea1eb00$0100a8c0@zultys.com>
Message-ID: <Pine.LNX.4.44.0301041435320.18708-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If only the Linux kernel had something as heart-warming as FreeBSD's
> "diediedie ()". :D
How about this:

arch/m68k/mac/psc.c

/*
 * Try to kill all DMA channels on the PSC. Not sure how this his
 * supposed to work; this is code lifted from macmace.c and then
 * expanded to cover what I think are the other 7 channels.
 */

void psc_dma_die_die_die(void)
{
        int i;

        printk("Killing all PSC DMA channels...");
        for (i = 0 ; i < 9 ; i++) {
                psc_write_word(PSC_CTL_BASE + (i << 4), 0x8800);
                psc_write_word(PSC_CTL_BASE + (i << 4), 0x1000);
                psc_write_word(PSC_CMD_BASE + (i << 5), 0x1100);
                psc_write_word(PSC_CMD_BASE + (i << 5) + 0x10, 0x1100);
        }
        printk("done!\n");
}


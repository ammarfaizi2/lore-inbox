Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131694AbRCTA6H>; Mon, 19 Mar 2001 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131695AbRCTA55>; Mon, 19 Mar 2001 19:57:57 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:46865 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S131694AbRCTA5r>; Mon, 19 Mar 2001 19:57:47 -0500
Date: Mon, 19 Mar 2001 19:57:32 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>, Ollie Lho <ollie@sis.com.tw>
Subject: Trident sound driver - global registers not restored
Message-ID: <Pine.LNX.4.33.0103191948190.3678-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The driver for Trident sound cards in 2.4.2-ac20 has functions
ali_save_regs() and ali_restore_regs() that are supposed to save and
restore the hardware registers over the power management events.

ali_restore_regs() restores mixer and channel registers from memory, but
it _saves_ the global registers instead of restoring them:

ali_registers.global_regs[i] = inl(TRID_REG(card, i*4));

It must be an error (most likely a result of cut-and-paste).

Regards,
Pavel Roskin


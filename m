Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265676AbUGDN0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbUGDN0s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 09:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUGDN0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 09:26:48 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:20747 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265676AbUGDN0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 09:26:46 -0400
To: bert hubert <ahu@ds9a.nl>
Cc: Zinx Verituse <zinx@epicsol.org>, linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
References: <20040626222304.GA31195@bliss>
	<87hdsoghdv.fsf@devron.myhome.or.jp>
	<20040704111623.GA12255@outpost.ds9a.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 04 Jul 2004 22:26:34 +0900
In-Reply-To: <20040704111623.GA12255@outpost.ds9a.nl>
Message-ID: <87llhzlx85.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> writes:

> On Sun, Jul 04, 2004 at 08:07:40PM +0900, OGAWA Hirofumi wrote:
> 
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Transmit timeout, status 0d 0000 c07f media 08.
> > eth0: Tx queue start entry 25  dirty entry 21.
> > eth0:  Tx descriptor 0 is 10080062.
> > eth0:  Tx descriptor 1 is 00080062. (queue head)
> > eth0:  Tx descriptor 2 is 00080062.
> > eth0:  Tx descriptor 3 is 00080062.
> > eth0: link up, 10Mbps, half-duplex, lpa 0x0000
> > rtl8139_hw_start: init buffer addresses
> 
> I've solved this exact problem in the bios by changing interrupts from level
> to edge, or the other way around, unsure.
>
> Earlier 2.6 did not have problems with that bios setting.

Yes. 8139too.c with NAPI requires the level triggered interrrut. (PCI
spec also requires it)

However, this registers doesn't indicate the lost interrupt problem.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

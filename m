Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266541AbVBED3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266541AbVBED3X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 22:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbVBED3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 22:29:22 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:34696 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S266541AbVBEC6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:58:32 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 3TB disk hassles
To: Neil Conway <nconway_kernel@yahoo.co.uk>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 05 Feb 2005 03:58:39 +0100
References: <fa.fng0mbi.10jm21g@ifi.uio.no> <fa.ls0rpqi.104a23q@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CxG9f-0005Yi-Sp@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Conway <nconway_kernel@yahoo.co.uk> wrote:

> I thought sure I had read somewhere that typical x86 PC BIOSes just
> didn't understand the GPT ptbl, and thus couldn't boot from a GPT'ed
> disk.

No common x86 BIOS can understand any partition table. Booting is done by
loading the first sector of the boot device and executing it. The common
MBR code will move it's code to a unused location, load the first sector
of the active partition and execute it. If you replace the MBR code with
the GPT MBR code, it should understand GPTs. If you replace it with lilo
or grub, one of these tools will run. If you replace it with a boot virus,
it will (usurally) install it's hooks and chain-load the original boot
sector, which in turn does it's work.

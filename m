Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265079AbUELAAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUELAAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUELAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:00:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:28079 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263467AbUELAAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:00:05 -0400
Date: Tue, 11 May 2004 17:02:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Long boot delay with 2.6 on Tyan S2464 Dual Athlon
Message-Id: <20040511170238.36f9e5f3.akpm@osdl.org>
In-Reply-To: <20040511143514.GB27033@ti64.telemetry-investments.com>
References: <20040511143514.GB27033@ti64.telemetry-investments.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com> wrote:
>
> When booting 2.6 on a Tyan S2464 dual Athlon, the kernel pauses
> for about two minutes before the first boot message appears.
> This does not occur with 2.4 kernels.
> 
> The machine has a Matrox G450 AGP (which overrides the onboard ATI),
> a 3ware 7500 RAID controller, IDE on the motherboard, and 1GB of RAM.
> 
> I've tried numerous option combinations in both the BIOS and the
> kernel: MPS 1.1/1.4, (no-)SMP, acpi=off, pci=noacpi, noapic, nolapic,
> nousb, etc.

Can you try adding earlyprintk=vga?  That might help identify where it got
stuck.


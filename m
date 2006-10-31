Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161571AbWJaHsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161571AbWJaHsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161573AbWJaHsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:48:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161571AbWJaHsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:48:10 -0500
Date: Mon, 30 Oct 2006 23:48:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-Id: <20061030234800.cd2b70f9.akpm@osdl.org>
In-Reply-To: <20061030233432.d75955c5.akpm@osdl.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061030191340.1c7f8620.akpm@osdl.org>
	<200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061030211046.1c3d62b9.akpm@osdl.org>
	<20061031070351.GB14713@kroah.com>
	<20061030233432.d75955c5.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 23:34:32 -0800
Andrew Morton <akpm@osdl.org> wrote:

> (That test machine is
> running FC1, which doesn't run udev at all.  Its BIOS is acpi-free).

Not that this is relevant - the machine went splat well before userspace
started up.

It has some krufty old audio card, but I don't think Andrew's .config even
selected it.  Yet it oopsed in alsa code.  Am not sure where the other oops
was.

vmm:/home/akpm> lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
01:00.0 VGA compatible controller: nVidia Corporation NV18GL [Quadro4 NVS AGP 8x] (rev a2)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUJYRjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUJYRjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUJYRf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:35:57 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:61675 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261211AbUJYRcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:32:39 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.6.9] unhandled OHCI IRQs...
Date: Mon, 25 Oct 2004 10:13:26 -0700
User-Agent: KMail/1.6.2
Cc: "Daniel Blueman" <daniel.blueman@gmx.net>, linux-kernel@vger.kernel.org
References: <16118.1098649213@www5.gmx.net>
In-Reply-To: <16118.1098649213@www5.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410251013.26615.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 13:20, Daniel Blueman wrote:
> When plugging in an Epson C62 USB 1.1 printer to my nForce 2 OHCI + EHCI USB
> controllers, the IRQ doesn't seem to get handled [1]. Tried both with
> acpi=noirq and without, printer support and full USB support enabled. Kernel
> is 2.6.9.
> 
> Any ideas?

Make sure your BIOS isn't trying to do any more with USB than just
enabling the hardware ... or try the new PCI "quirk" flag affecting
boot-time handling of USB, merged in 2.6.10-rc1.

- Dave


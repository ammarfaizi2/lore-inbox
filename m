Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUFXKea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUFXKea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFXKea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:34:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:43438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264211AbUFXKeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:34:17 -0400
Date: Thu, 24 Jun 2004 03:33:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-acpi@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2
Message-Id: <20040624033321.7366ac67.akpm@osdl.org>
In-Reply-To: <20040624014655.5d2a4bfb.akpm@osdl.org>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/
> 
> ...
>   bk-acpi.patch

OK, ACPI seems to have progressed in a non-forward direction here.

If anyone has weird problems, please do a `patch -p1 -R' of

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/broken-out/bk-acpi.patch

USB doesn't come up:

usb 2-1: control timeout on ep0out
uhci_hcd 0000:00:1d.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
usb 2-1: control timeout on ep0out
usb 2-1: device not accepting address 2, error -110
usb 2-1: new low speed USB device using address 3
usb 2-1: control timeout on ep0out
usb 2-1: control timeout on ep0out
usb 2-1: device not accepting address 3, error -110
usb 2-2: new full speed USB device using address 4
usb 2-2: control timeout on ep0out
usb 2-2: control timeout on ep0out
usb 2-2: device not accepting address 4, error -110
usb 2-2: new full speed USB device using address 5
usb 2-2: control timeout on ep0out
usb 2-2: control timeout on ep0out
usb 2-2: device not accepting address 5, error -110

dmesg without bk-acpi.patch:
	http://www.zip.com.au/~akpm/linux/patches/stuff/dmesg-good
dmesg with bk-acpi.patch:
	http://www.zip.com.au/~akpm/linux/patches/stuff/dmesg-bad


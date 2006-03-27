Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWC0Xio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWC0Xio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWC0Xio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:38:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbWC0Xin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:38:43 -0500
Date: Mon, 27 Mar 2006 15:40:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: norsk5@xmission.com, dthompson@linuxnetworx.com, dsp@llnl.gov,
       dave_peterson@pobox.com, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] edac_752x needs CONFIG_HOTPLUG
Message-Id: <20060327154055.564404f0.akpm@osdl.org>
In-Reply-To: <20060327150637.5aaf6493.rdunlap@xenotime.net>
References: <20060327150637.5aaf6493.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> EDAC_752X uses pci_scan_single_device(), which is only available
> if CONFIG_HOTPLUG is enabled

hm.  That's not a hotpluggable device, surely?

If not then either a) PCI should be implementing pci_scan_single_device()
if !CONFIG_HOTPLUG or b) EDAC shouldn't be using pci_scan_single_device().


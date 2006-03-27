Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWC0XrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWC0XrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWC0XrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:47:07 -0500
Received: from xenotime.net ([66.160.160.81]:3820 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932066AbWC0XrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:47:06 -0500
Date: Mon, 27 Mar 2006 15:49:21 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: norsk5@xmission.com, dthompson@linuxnetworx.com, dsp@llnl.gov,
       dave_peterson@pobox.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] edac_752x needs CONFIG_HOTPLUG
Message-Id: <20060327154921.9f0a281d.rdunlap@xenotime.net>
In-Reply-To: <20060327154055.564404f0.akpm@osdl.org>
References: <20060327150637.5aaf6493.rdunlap@xenotime.net>
	<20060327154055.564404f0.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006 15:40:55 -0800 Andrew Morton wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > EDAC_752X uses pci_scan_single_device(), which is only available
> > if CONFIG_HOTPLUG is enabled
> 
> hm.  That's not a hotpluggable device, surely?
> 
> If not then either a) PCI should be implementing pci_scan_single_device()
> if !CONFIG_HOTPLUG or b) EDAC shouldn't be using pci_scan_single_device().

or just that one if block should be surrounded by CONFIG_HOTPLUG
(done cleanly, of course).

---
~Randy

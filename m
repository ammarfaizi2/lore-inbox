Return-Path: <linux-kernel-owner+w=401wt.eu-S1758161AbWLID1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbWLID1Q (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbWLID1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:27:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33474 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758161AbWLID1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:27:16 -0500
Date: Fri, 8 Dec 2006 19:26:18 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: 2.6.19-git libusual: modprobe for usb-storage succeeded, but
 module is not present
Message-Id: <20061208192618.3959fda8.zaitcev@redhat.com>
In-Reply-To: <20061208190829.rvzeyaq4pxj40gko@69.222.0.225>
References: <20061208190829.rvzeyaq4pxj40gko@69.222.0.225>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 19:08:29 -0600, art@usfltd.com wrote:

> usb 2-2: new high speed USB device using ehci_hcd and address 3
> usb 2-2: configuration #1 chosen from 1 choice
> libusual: modprobe for usb-storage succeeded, but module is not present
> usb 2-4: new high speed USB device using ehci_hcd and address 5
> usb 2-4: configuration #1 chosen from 1 choice
> libusual: modprobe for usb-storage succeeded, but module is not present
> usb 2-5: new high speed USB device using ehci_hcd and address 6
> usb 2-5: configuration #1 chosen from 1 choice
> libusual: modprobe for usb-storage succeeded, but module is not present

I don't know what you've done to accomplish it, but either your
modules got separated (e.g. libusual built statically while usb-storage
is dynamic), or your modprobe is toast, or 100 other reasons.

Just deconfigure CONFIG_BLK_DEV_UB and CONFIG_USB_LIBUSUAL
and forget about it all.

I know, I have to think of a workaround for this, but nothing is
readily apparent.

-- Pete

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVHCRuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVHCRuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 13:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVHCRuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 13:50:13 -0400
Received: from fmr22.intel.com ([143.183.121.14]:41376 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262373AbVHCRuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 13:50:10 -0400
Date: Wed, 3 Aug 2005 10:49:43 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: kylin <fierykylin@gmail.com>
Cc: rajesh.shah@intel.com, linux-kernel@vger.kernel.org,
       linux-newbie@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Message-ID: <20050803104940.A3754@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <87ab37ab0507300920570b0ea6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87ab37ab0507300920570b0ea6@mail.gmail.com>; from fierykylin@gmail.com on Sun, Jul 31, 2005 at 12:20:30AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 12:20:30AM +0800, kylin wrote:
> I wonder if i can workaround the MSI using the polling way on the
> server geared by E7520 and the firmware with no OSC implemented
> 
Per the PCI firmware spec (I'm looking at draft 0.9, version 3.0),
the OS must explicitly get control of native pcie hotplug from
firmware using _OSC before trying to use it. Firmware may be
deliberately not creating an _OSC because it is controlling the
hotplug hardware, or may be aware of other reasons (e.g. errata)
why OS native pcie hotplug should not be used on this platform.
So no, I don't think we can load and use pciehp if there's
no _OSC implemented in firmware.

Rajesh

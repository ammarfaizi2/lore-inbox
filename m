Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265347AbVBFEFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265347AbVBFEFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVBFEFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:05:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59818 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S271951AbVBFEF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:05:27 -0500
Date: Sat, 5 Feb 2005 23:05:26 -0500
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
Message-ID: <20050206040526.GA2908@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910502051745c25d6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502051745c25d6f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 08:45:19PM -0500, Jon Smirl wrote:
 > I have an i875 chipset with these two devices:
 > 
 > 8086:2578 - 00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory
 > Controller Hub (rev 02)
 > 8086:2579 - 00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP
 > Controller (rev 02)
 > 
 > In the legacy io space thread we are talking about making a device
 > driver for host bridges.  The Intel AGP drivers (in my case
 > agpgart-intel-mch) are attaching to the PCI IDs of the host bus device
 > instead of the AGP bridge. This blocks us from making a host bridge
 > driver.
 > PCI_DEVICE_ID_INTEL_82875_HB 0x2578
 > 
 > Shouldn't they be attaching to device 0x2579? It looks like all of the
 > drivers have this problem and are attaching to the host bus PCI IDs
 > instead of the AGP bridge ID.

Take a peek at 'lspci -vv' output. You'll notice that the AGP
capabilities are attached to the host bridge.

		Dave


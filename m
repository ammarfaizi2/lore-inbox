Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbWALUtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWALUtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbWALUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:49:53 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:6600 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161259AbWALUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:49:52 -0500
Message-ID: <43C6C0E6.7030705@gentoo.org>
Date: Thu, 12 Jan 2006 20:49:42 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Mason <jdmason@us.ibm.com>
CC: mulix@mulix.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: pcnet32 devices with incorrect trident vendor ID
References: <20060112175051.GA17539@us.ibm.com>
In-Reply-To: <20060112175051.GA17539@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason wrote:
> Some pcnet32 hardware erroneously has the Vendor ID for Trident.  The
> pcnet32 driver looks for the PCI ethernet class before grabbing the
> hardware, but the current trident driver does not check against the
> PCI audio class.  This allows the trident driver to claim the pcnet32 
> hardware.  This patch prevents that.

On the subject of pcnet32 and the invalid vendor ID, you may find this 
interesting:

http://forums.gentoo.org/viewtopic-t-420013-highlight-trident.html

The user saw the correct vendor ID (AMD) in 2.4, but when upgrading to 
2.6, it changed to Trident.

I guess this is still likely to be a hardware bug, but it demonstrates 
that the Linux PCI layer has something to do with it (even if it is just 
triggering it somehow).

Daniel

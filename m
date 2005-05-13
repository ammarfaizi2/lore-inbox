Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVEMSE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVEMSE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVEMSE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:04:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22998 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262435AbVEMSEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:04:53 -0400
Message-ID: <4284EC3D.1050406@pobox.com>
Date: Fri, 13 May 2005 14:04:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Juerg Billeter <juerg@paldo.org>
CC: achew@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: Broken nForce2 IDE module loading via hotplug
References: <1113669215.8940.31.camel@juerg-p4.bitron.ch>
In-Reply-To: <1113669215.8940.31.camel@juerg-p4.bitron.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Billeter wrote:
> Hi
> 
> (please cc me)
> 
> The sata_nv patch[1] (merged in 2.6.11-rc4) to enable future NVIDIA SATA
> pci ids catches all NVIDIA pci devices with the ide class. This breaks
> automatic module loading for e.g. nForce2 ide controllers and thereby
> renders nForce systems loading modules already in initramfs/initrd via
> hotplug/coldplug non-bootable.
> 
> I don't know what solutions are possible besides reverting. Is it
> somehow possible to influence the order of the modules.pcimap file, i.e.
> moving the generic matching lines below the more specific ones?

It might be fair to add a kernel config option to disable the generic entry.

	Jeff




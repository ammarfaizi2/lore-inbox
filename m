Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbULIGAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbULIGAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 01:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbULIGAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 01:00:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48783 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261461AbULIGAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 01:00:44 -0500
Subject: Re: Figuring out physical memory regions from a kernel module
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
Content-Type: text/plain
Organization: 
Message-Id: <1102573540.2493.32.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Dec 2004 11:55:40 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about reading /proc/iomem with some user space utility, parse it and
pass it to your module as parameters during insmod.

On Wed, 2004-12-08 at 23:14, Hanson, Jonathan M wrote:
> 	Is there a reliable way to tell from a kernel module (currently
> written for 2.4 but will need to work under 2.6 in the future) which
> regions of physical memory are actually available for the kernel and
> processes to use? For example, the following command tells me the
> regions of physical memory that are available to use:
> 
> cat /proc/iomem | grep 'System RAM'
> 
> This yields something like the following on my x86 system:
> 
> 00000000-0009ffff : System RAM
> 00100000-1ffd5857 : System RAM
> 
> I need to be able to determine these regions from within a kernel
> module. The e820 data structures configured at kernel boot-time are not
> exported so I can't see them from a kernel module, otherwise they would
> be perfect. For my purposes, I'm operating under the assumption that all
> physical memory can be mapped by the kernel (under 896 MB of physical
> memory). Can anyone recommend a way to get to this data? I would greatly
> appreciate it.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


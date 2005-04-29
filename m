Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVD2FHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVD2FHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVD2FHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:07:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38651 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262194AbVD2FHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:07:32 -0400
Date: Fri, 29 Apr 2005 10:37:29 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, sharyathi@in.ibm.com,
       fastboot@lists.osdl.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kdump docs.
Message-ID: <20050429050729.GB3636@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com> <OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com> <20050425160925.3a48adc5.rddunlap@osdl.org> <20050426085448.GB4234@in.ibm.com> <20050427122312.358f5bd6.rddunlap@osdl.org> <20050428114416.GA5706@in.ibm.com> <20050428091119.73568208.rddunlap@osdl.org> <20050428200845.5211ec37.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428200845.5211ec37.rddunlap@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> +  A) First kernel:
> +   a) Enable "kexec system call" feature (in Processor type and features).
> +	CONFIG_KEXEC=y
> +   b) This kernel's physical load address should be the default value of
> +      0x100000 (0x100000, 1 MB) (in Processor type and features).
> +	CONFIG_PHYSICAL_START=0x100000
> +   c) Enable "sysfs file system support" (in Pseudo filesystems).
> +	CONFIG_SYSFS=y
> +   d) Boot into first kernel with the command line parameter "crashkernel=Y@X".
> +      Use appropriate values for X and Y. Y denotes how much memory to reserve
> +      for the second kernel, and X denotes at what physical address the reserved
> +      memory section starts. For example: "crashkernel=64M@16M".
> +
> +  B) Second kernel:
> +   a) Enable "kernel crash dumps" feature (in Processor type and features).
> +	CONFIG_CRASH_DUMP=y
> +   b) Specify a suitable value for "Physical address where the kernel is
> +      loaded" (in Processor type and features). Typically this value
> +      should be same as X (See option b) above, e.g., 16 MB or 0x1000000.

Should above line be as follows.
"should be same as X (See option d) above."

This will make clear what is X and what should be the new value of 
CONFIG_PHYSICAL_START. 

Thanks for testing out and providing a clearer documentation.

Thanks
Vivek


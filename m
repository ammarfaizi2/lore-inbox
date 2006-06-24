Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWFXGzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWFXGzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 02:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWFXGzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 02:55:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750879AbWFXGzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 02:55:21 -0400
Date: Fri, 23 Jun 2006 23:55:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-scsi@vger.kernel.org, ebiederm@xmission.com, mike.miller@hp.com
Subject: Re: [RFC] [PATCH 1/2] introduce crashboot kernel command line
 parameter
Message-Id: <20060623235514.48ea9578.akpm@osdl.org>
In-Reply-To: <20060623210121.GA18384@in.ibm.com>
References: <20060623210121.GA18384@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 17:01:21 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> o Add kernel command line option "crashboot"
> 
> o This option is an indication to the kernel that kernel is booting in an
>   unreliable environment where possibly BIOS execution has been skipped
>   and devices are left operational or in unknown state.
> 
> o Kernel, especially device drivers can use this option to take special
>   actions like soft-resetting the device, relaxing some of the rules
>   to make sure kernel can boot/device driver can initiliaze in this
>   environment.
> 
> o As of today this option is useful to Kdump. Kdump will pass this option
>   to second kernel to improve the reliability of successful kenrel boot/
>   device driver initializatoin. 

It worries me that this will be used to work around driver problems rather
than fixing them properly.


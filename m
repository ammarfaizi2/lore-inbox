Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbVCJWRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbVCJWRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263287AbVCJWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:14:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:64214 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262831AbVCJWCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:02:10 -0500
Date: Thu, 10 Mar 2005 14:01:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050310140137.09c7040b.akpm@osdl.org>
In-Reply-To: <200503102142.j2ALgCg04691@unix-os.sc.intel.com>
References: <20050310123043.69e5fd48.akpm@osdl.org>
	<200503102142.j2ALgCg04691@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Let me work on the readv/writev support (unless someone beat me to it).

Please also move it to the address_space_operations level.  Yes, there are
performance benefits from simply omitting the LFS checks, the mmap
consistency fixes, etc.  But they're there for a reason.


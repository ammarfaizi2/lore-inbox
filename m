Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWEMPq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWEMPq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWEMPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:46:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932452AbWEMPq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:46:27 -0400
Date: Sat, 13 May 2006 08:43:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might
 be dm related)
Message-Id: <20060513084317.50356155.akpm@osdl.org>
In-Reply-To: <20060513153231.GA6277@uio.no>
References: <1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<20060426204809.GA15462@uio.no>
	<20060426135809.10a37ec3.akpm@osdl.org>
	<20060513134908.GA4480@uio.no>
	<20060513073344.4fcbc46b.akpm@osdl.org>
	<20060513144334.GA6013@uio.no>
	<20060513075147.423d18bd.akpm@osdl.org>
	<20060513150003.GA6096@uio.no>
	<20060513082409.4d173ccc.akpm@osdl.org>
	<20060513153231.GA6277@uio.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steinar H. Gunderson" <sgunderson@bigfoot.com> wrote:
>
>  > Which kind of implies that we passed a null (or very small small) `struct
>  > kmem_cache' pointer into kmem_cache_free().  But that doesn't seem like the
>  > sort of thing which will take hours to reproduce.
>  > 
>  > Do you have CONFIG_NUMA set?
> 
>  Hm, yes, for some reason CONFIG_NUMA, CONFIG_K8_NUMA and
>  CONFIG_x86_64_ACPI_NUMA are all set; I guess they're left from the stock
>  config I use at a base. (For those tuning in; this is a dual-core amd64. That
>  might be relevant somehow.)

Please try it without NUMA - we've had a few problems there of late.  If
that fixes it then I have patches for you to test ;)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVCQLcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVCQLcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVCQLbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:31:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:7644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263046AbVCQKgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:36:22 -0500
Date: Thu, 17 Mar 2005 02:36:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, anton@samba.org, moilanen@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Implement non-executable stacks
Message-Id: <20050317023600.6582772c.akpm@osdl.org>
In-Reply-To: <16953.19246.642337.272696@cargo.ozlabs.ibm.com>
References: <16953.19246.642337.272696@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
>  This patch, by Jake Moilanen with some further hacking from me, adds a
>  real execute permission bit to the linux PTEs on PPC64, and connects
>  that into the kernel infrastructure for implementing non-executable
>  stacks and heaps.  This means that on any PPC64 cpu since the POWER4
>  (i.e. POWER4, PPC970, PPC970FX, POWER4+, POWER5) you will get a
>  segfault if you try to execute instructions from a region that doesn't
>  have PROT_EXEC permission.  The patch also marks the pages of the
>  linear mapping that aren't part of the kernel text as non-executable.
> 
>  Andrew and Linus, could you try this on your G5s? 

Seems to work OK under ydl 4.0.  OpenOffice hung once starting up, but that
wasn't repeatable.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVCDH6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVCDH6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCDH5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:57:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:21687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262615AbVCDH53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:57:29 -0500
Date: Thu, 3 Mar 2005 23:56:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Justin Schoeman <justin@expertron.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tracing memory leaks (slabs) in 2.6.9+ kernels?
Message-Id: <20050303235633.694e87c6.akpm@osdl.org>
In-Reply-To: <422812D9.4090303@expertron.co.za>
References: <4225768B.3010005@expertron.co.za>
	<20050302012444.4ed05c23.akpm@osdl.org>
	<422700CB.2070109@expertron.co.za>
	<20050303042620.685133db.akpm@osdl.org>
	<422812D9.4090303@expertron.co.za>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Schoeman <justin@expertron.co.za> wrote:
>
> Will the slab debugger make it into the kernel as a standard compile 
>  time option?  It is a _really_ usefull tool to have around.

It has a slight downside: it unconditionally changes the type of
kmem_bufctl_t to unsigned long, which wastes two or four bytes per page of
slab.

I suppose we could fix that up with suitable use of CONFIG_DEBUG_SLAB.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVCOF23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVCOF23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVCOF23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:28:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:3263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbVCOF20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:28:26 -0500
Date: Mon, 14 Mar 2005 21:28:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC]: DEBUG for PCI IO & MEM allocation
Message-Id: <20050314212812.3657cfd4.akpm@osdl.org>
In-Reply-To: <4235C88B.9090708@sgi.com>
References: <4235C88B.9090708@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit Bhargava <prarit@sgi.com> wrote:
>
>  I propose the following patch to add a compile time DEBUG option to 
>  kernel/resource.c that would help in analyzing problems in this area.  
>  It's a few simple lines of output in  __request_resource, 
>  __release_resource, __request_region, and __release_region .
> 

A sane enough requirement.

>   
>  +	DEBUGP("%s: resource request at 0x%lx-0x%lx\n", __FUNCTION__, new->start, new->end);

Shouldn't this also be printing the ->name of the new resource?

A lot of the statements which you're adding will look screwy in an 80-col
xterm.  Please wrap 'em.

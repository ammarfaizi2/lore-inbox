Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVERCEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVERCEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 22:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVERCEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:04:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:32643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262046AbVERCEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:04:41 -0400
Date: Tue, 17 May 2005 19:03:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@graphe.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers
 for e1000
Message-Id: <20050517190343.2e57fdd7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@graphe.net> wrote:
>
> NUMA awareness for the e1000 driver. Allocate transmit and receive buffers
> on the node of the device.

Hast thou any benchmarking results?

> -	txdr->buffer_info = vmalloc(size);
> +	txdr->buffer_info = kmalloc_node(size, GFP_KERNEL, node);

How come this is safe to do?

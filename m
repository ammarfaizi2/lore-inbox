Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWGADiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWGADiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWGADiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:38:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbWGADiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:38:07 -0400
Date: Fri, 30 Jun 2006 20:34:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/fremap.c: EXPORT_UNUSED_SYMBOL
Message-Id: <20060630203453.81700a1f.akpm@osdl.org>
In-Reply-To: <20060630113153.GM19712@stusta.de>
References: <20060630113153.GM19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:31:53 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> This patch marks an unused export as EXPORT_UNUSED_SYMBOL.
> 
> -EXPORT_SYMBOL(install_page);
> +EXPORT_UNUSED_SYMBOL(install_page);  /*  June 2006  */

install_page() is a library function which any implementation of
vm_operations_struct.populate() will need to be able to call.

Please drop.

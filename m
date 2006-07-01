Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWGADjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWGADjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWGADiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:38:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932423AbWGADic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:38:32 -0400
Date: Fri, 30 Jun 2006 20:35:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [2.6 patch] mm/memory.c: EXPORT_UNUSED_SYMBOL
Message-Id: <20060630203513.ef0ade5b.akpm@osdl.org>
In-Reply-To: <20060630113240.GP19712@stusta.de>
References: <20060630113240.GP19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:32:40 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> -EXPORT_SYMBOL(vmtruncate_range);
> +EXPORT_UNUSED_SYMBOL(vmtruncate_range);  /*  June 2006  */

vmtruncate_range() is a sensible-looking API, but it's purely for
MADV_REMOVE and I don't think it's a thing we intended that filesystems be
using, and I don't think that it's a thing which we want to be supporting
as an export unless there's a good reason.

So yes, let's give this a try.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVDLKWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVDLKWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVDLKWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:22:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:25029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262102AbVDLKWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:22:23 -0400
Date: Tue, 12 Apr 2005 03:22:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: jes@trained-monkey.org (Jes Sorensen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-Id: <20050412032209.1609922a.akpm@osdl.org>
In-Reply-To: <16987.39773.267117.925489@jaguar.mkp.net>
References: <16987.39773.267117.925489@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jes@trained-monkey.org (Jes Sorensen) wrote:
>
> + getpage:
>  +	/*
>  +	 * Is this really correct?
>  +	 */
>  +	page = alloc_pages(GFP_USER, 0);
>  +	spin_unlock(&vdata->lock);
>  +	return page;
>  +

sleeping allocation inside a spinlock.

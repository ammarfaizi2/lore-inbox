Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbVIBWKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbVIBWKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbVIBWKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:10:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161036AbVIBWKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:10:48 -0400
Date: Fri, 2 Sep 2005 15:13:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [PATCH 07/11] memory hotplug: sysfs and add/remove functions
Message-Id: <20050902151311.5f292ef5.akpm@osdl.org>
In-Reply-To: <20050902205648.07018412@kernel.beaverton.ibm.com>
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
	<20050902205648.07018412@kernel.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> +		for (i = 0; i < PAGES_PER_SECTION; i++) {
> +			if (PageReserved(first_page+i))
> +				continue;

How intimate do these patches get with PageReserved()?  Bear in mind that
we're slowly working toward making PageReserved go away.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWHHGB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWHHGB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWHHGB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:01:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932170AbWHHGB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:01:27 -0400
Date: Mon, 7 Aug 2006 23:01:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andi Kleen <ak@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86_64:  Auto size the per cpu area.
Message-Id: <20060807230116.3c9247d6.akpm@osdl.org>
In-Reply-To: <m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
	<20060807165512.dabefb63.akpm@osdl.org>
	<200608080417.59462.ak@suse.de>
	<20060807194159.f7c741b5.akpm@osdl.org>
	<1155005284.3042.11.camel@laptopd505.fenrus.org>
	<m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 23:47:23 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> +#ifdef CONFIG_MODULES
> +# define PERCPU_MODULE_RESERVE 8192
> +#else
> +# define PERCPU_MODULE_RESERVE 0
> +#endif
> +
> +#define PERCPU_ENOUGH_ROOM \
> +	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
> +	 PERCPU_MODULE_RESERVE)
> +

Seems sane, but isn't 8192 a bit small?

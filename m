Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTJWOmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTJWOmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:42:45 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:33944 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263575AbTJWOmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:42:44 -0400
Date: Thu, 23 Oct 2003 07:42:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Autoregulate vm swappiness 2.6.0-test8
Message-ID: <8720000.1066920153@[10.10.2.4]>
In-Reply-To: <200310232337.50538.kernel@kolivas.org>
References: <200310232337.50538.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	 * Autoregulate vm_swappiness to be application pages % -ck.
> +	 */
> +	si_meminfo(&i);
> +	si_swapinfo(&i);
> +	pg_size = get_page_cache_size() - i.bufferram ;
> +	vm_swappiness = 100 - (((i.freeram + i.bufferram +
> +		(pg_size - swapper_space.nrpages)) * 100) /
> +		(i.totalram ? i.totalram : 1));
> +
> +	/*

It seems that you don't need si_swapinfo here, do you? i.freeram,
i.bufferram, and i.totalram all come from meminfo, as far as I can
see? Maybe I'm missing a bit ...

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWHPRQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHPRQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHPRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:16:14 -0400
Received: from ns.suse.de ([195.135.220.2]:46744 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751145AbWHPRQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:16:13 -0400
Date: Wed, 16 Aug 2006 10:15:27 -0700
From: Greg KH <greg@kroah.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
Message-ID: <20060816171527.GB27898@kroah.com>
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33BB6.3050504@sw.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:37:26PM +0400, Kirill Korotaev wrote:
> +struct user_beancounter
> +{
> +	atomic_t		ub_refcount;

Why not use a struct kref here instead of rolling your own reference
counting logic?

thanks,

greg k-h

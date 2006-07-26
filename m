Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWGZKo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWGZKo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWGZKo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:44:27 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:12674 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932524AbWGZKo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:44:26 -0400
Date: Wed, 26 Jul 2006 14:44:07 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [1/4] kevent: core files.
Message-ID: <20060726104407.GB10459@2ka.mipt.ru>
References: <11539054941027@2ka.mipt.ru> <11539054952689@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <11539054952689@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 26 Jul 2006 14:44:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:18:15PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> +struct kevent *kevent_alloc(gfp_t mask)
> +{
> +	struct kevent *k;
> +	
> +	if (kevent_cache)
> +		k = kmem_cache_alloc(kevent_cache, mask);
> +	else
> +		k = kzalloc(sizeof(struct kevent), mask);
> +
> +	return k;
> +}
> +

Sorry for that.
It is fixed already to always use cache, but I forget to commit that
change before I created pachset.

-- 
	Evgeniy Polyakov

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbSI1Jqx>; Sat, 28 Sep 2002 05:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSI1Jqx>; Sat, 28 Sep 2002 05:46:53 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:4231 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262785AbSI1Jqw>; Sat, 28 Sep 2002 05:46:52 -0400
Date: Sat, 28 Sep 2002 03:52:48 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
In-Reply-To: <20020928093335.E7A794@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0209280352270.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Lightweight Patch Manager wrote:
> +/**
> + * slist_del_init -	remove an entry from list and initialize it
> + * @head:	head to remove it from
> + * @entry:	entry to be removed
> + */
> +#define slist_del_init(_entry_in)			\
> +({							\
> +	typeof(_entry_in) _entry = (_entry_in), _head =	\
> +	    kmalloc(sizeof(_entry), GFP_KERNEL), _free;	\
> +	if (_head) {					\
> +	    memcpy(_head, (_entry), sizeof(_entry));	\
> +	    _free = (_entry);				\
> +	    (_entry) = (_entry)->next;			\
> +	    kfree(_free);				\
> +	    _head->next = _head;			\
> +	    _head;					\
> +	} else						\
> +	    NULL;					\
> +})

Forget this piece...

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSIZVOQ>; Thu, 26 Sep 2002 17:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSIZVOQ>; Thu, 26 Sep 2002 17:14:16 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:8426 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261530AbSIZVN4>; Thu, 26 Sep 2002 17:13:56 -0400
Date: Thu, 26 Sep 2002 15:19:52 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44.0209261511290.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0209261519280.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Thunder from the hill wrote:
> /**
>  * slist_del -  remove an entry from list
>  * @buf:        a storage area, just as long as the entry
>  * @entry:      entry to be removed
>  */
> #define slist_del(_entry_in,_buf)			\
> do {							\
> 	typeof(_entry_in) _entry = (_entry_in),		\
> 			  _head = (_buf), _free;	\
> 	memcpy(_head, _entry, sizeof(_entry));		\
> 	_free = _entry;					\
> 	_entry = _entry->next;				\
> 	_head->next = NULL;				\
> 	(_buf) = _head;					\
	^^^^^^^^^^^^^^^ Ignore this
> } while (0)


			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */


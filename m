Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWGHSaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWGHSaw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWGHSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:30:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:8386 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964945AbWGHSav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:30:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
Date: Sat, 8 Jul 2006 20:31:17 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200607080124.21856.dtor@insightbb.com>
In-Reply-To: <200607080124.21856.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607082031.17638.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 08 July 2006 07:24 schrieb Dmitry Torokhov:
> +/**
> + * list_get - get first element in a list
> + * @head: the head of your list
> + */
> +static inline struct list_head *list_get(struct list_head *head)
> +{
> +       return head->next;
> +}

I would expect it to be more useful when combined with list_entry(),
something like

#define list_first_entry(list, type, member) \
	container_of((list)->next, type, member)
#define list_last_entry(list, type, member) \
	container_of((list)->prev, type, member)

	Arnd <><

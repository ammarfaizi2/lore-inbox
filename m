Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWGHXAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWGHXAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 19:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWGHXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 19:00:50 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:54756 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1030413AbWGHXAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 19:00:49 -0400
Reveived: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id 8663D49ED3;
	Sun,  9 Jul 2006 01:00:48 +0200 (CEST)
Date: Sun, 09 Jul 2006 01:00:48 +0200
Message-Id: <792328608@web.de>
MIME-Version: 1.0
From: Arne Ahrend <aahrend@web.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INFO: possible irq lock inversion dependency detected
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 19:12 +0200, Arjan van de Ven wrote:
> Arne: Can you try this patch and verify it makes the message go away?
> [...]
> --- linux-2.6.17-mm6.orig/include/linux/skbuff.h
> +++ linux-2.6.17-mm6/include/linux/skbuff.h
> @@ -609,7 +609,6 @@ extern struct lock_class_key skb_queue_l
>  static inline void skb_queue_head_init(struct sk_buff_head *list)
>  {
>  	spin_lock_init(&list->lock);
> -	lockdep_set_class(&list->lock, &skb_queue_lock_key);
>  	list->prev = list->next = (struct sk_buff *)list;
>  	list->qlen = 0;
>  }


Yes, this patch removes the message. (And the system continues to work.)

Arne


__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsstärkeren E-Mail-Postfach!		
Mehr Infos unter http://freemail.web.de/home/landingpad/?mc=021131


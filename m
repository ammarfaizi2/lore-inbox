Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVFUJdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVFUJdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVFUJc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:32:58 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:3992 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262090AbVFUJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:31:26 -0400
Date: Tue, 21 Jun 2005 11:31:19 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Domen Puncer <domen@coderock.org>
Subject: Re: [RFC] cleanup patches for strings
Message-ID: <20050621093119.GG27887@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <200506211259.22650.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506211259.22650.adobriyan@gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 June 2005 12:59:22 +0400, Alexey Dobriyan wrote:
> 
> > --- linux-2.6.12-orig/drivers/net/ibmlana.c
> > +++ linux-2.6.12/drivers/net/ibmlana.c
> 
> > -		char *fill = "NetBSD is a nice OS too! ";
> > +		char fill[] = "NetBSD is a nice OS too! ";
> 
> Don't:
>    5721	     16	      4	   5741	   166d	drivers/net/ibmlana.o	2.95.3-before
>    5737	     16	      4	   5757	   167d	drivers/net/ibmlana.o	2.95.3-after
>    5163	     16	      4	   5183	   143f	drivers/net/ibmlana.o	3.3.5-20050130-before
>    5169	     16	      4	   5189	   1445	drivers/net/ibmlana.o	3.3.5-20050130-after
>    4993	     16	      4	   5013	   1395	drivers/net/ibmlana.o	4.1-20050604-before
>    5028	     16	      4	   5048	   13b8	drivers/net/ibmlana.o	4.1-20050604-after

Please note that all the Dos have the magic word "static" while this
Don't doesn't.

Jörn

-- 
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbUKZT0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbUKZT0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUKZTVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:21:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262298AbUKZTU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:20:26 -0500
Message-ID: <41A7483F.9010302@pobox.com>
Date: Fri, 26 Nov 2004 10:14:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Any reason why we don't initialize all members of struct Xgt_desc_struct
 in doublefault.c ?
References: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Yes, this is nitpicking, but I just can't leave small corners like this 
> unpolished ;)
> 
> in arch/i386/kernel/doublefault.c you will find this (line 20) :
> 
> struct Xgt_desc_struct gdt_desc = {0, 0};
> 
> but, struct Xgt_desc_struct has 3 members, 
> 
> struct Xgt_desc_struct {
>         unsigned short size;
>         unsigned long address __attribute__((packed));
>         unsigned short pad;
> } __attribute__ ((packed));
> 
> so why only initialize two of them explicitly?

'pad' is a dummy variable... nobody cares about its value.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUJJQMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUJJQMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 12:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUJJQMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 12:12:53 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:35215 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S268330AbUJJQMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 12:12:51 -0400
Message-ID: <41695F85.A0000E3D@tv-sign.ru>
Date: Sun, 10 Oct 2004 20:12:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] __initdata strings
References: <2NNXM-1fZ-5@gated-at.bofh.it> <m38yae1ss7.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> There is a more generic way to do this with gcc extensions. Something like
> 
> #define __i(x) ({ static char __str[] __initdata = x; __str; })

I can't see any difference with:

#define I_STRING(str)  \
({                                             \
       static char data[] __initdata = (str);  \
       data;                                   \
})

> But I'm not sure the few bytes saved are worth the code uglification.

Probably you are right, but i think it would be few kilobytes,
there are so many __init functions.

Oleg.

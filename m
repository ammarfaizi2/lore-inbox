Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVHIFJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVHIFJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVHIFJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:09:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:49098 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750869AbVHIFJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:09:44 -0400
References: <20050808223842.GM4006@stusta.de>
In-Reply-To: <20050808223842.GM4006@stusta.de>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: make kcalloc() a static inline
Date: Tue, 09 Aug 2005 08:09:42 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F83A96.00001503@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes: 

> kcalloc() doesn't do much more than calling kzalloc(), and gcc has 
> better optimizing opportunities when it's inlined. 
> 
> The result of this patch with a fulll kernel compile (roughly equivalent 
> to "make allyesconfig") shows a minimal size improvement: 
> 
>     text           data     bss     dec             hex filename
> 25864955        5891214 2012840 33769009        2034631 vmlinux-before
> 25864635        5891206 2012840 33768681        20344e9 vmlinux-staticinline 
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi> 

       Pekka 

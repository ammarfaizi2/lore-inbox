Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVGCOOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVGCOOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVGCOOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 10:14:12 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:50720 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261446AbVGCOOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 10:14:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8ojqyDv0NKIbwBKHL8nj4UXBkBr63KQhv94SqPKBY2eAGMjyqwPD5M3aiqWsbjnPcWW0KGZ9cTa6q3TpsVm/jpKWvnIkTG6lBr3J1d6yRgKJO9VsoQswX1NzXyQznuugzca+8/3RkVCaZuNIKE2KnnEJGAxEWwoZjA1EhIX8Ms=
Message-ID: <9a8748490507030714d2a1b45@mail.gmail.com>
Date: Sun, 3 Jul 2005 16:14:07 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [PATCH] all-arch delay functions take 2
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200507031650.13770.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507031650.13770.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> Hi folks,
> 
> This patch makes mdelay/udelay/ndelay calls as small
> as possible (just a function call), uses macros which
> do compile-time checks on delay duration if parameter
> is a constant, otherwise check is done at run time
> to prevent udelay(-1) disasters.
> 
[snip]

> 
> -#define ndelay(n)      udelay((n) * 5)
> +//BOGUS! #define ndelay(n)     udelay((n) * 5)
> 
If it's bogus, why not just remove it instead of leaving it in as a
comment (and a C++ style comment at that) ?

[snip]
> +//extern struct timer_opts* timer;

Why add this at all if you are just going to comment it out anyway?



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWAFRt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWAFRt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbWAFRt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:49:57 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:46516 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752466AbWAFRt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:49:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dkbXGyjeI10OXmOeBJpfzmPv3lBwjKWVhjScAgHvObJNzKVtmDPfvcPlcm/9hzzsVmR2fvK2FCvKwTCdyngAK2fLy4/7wZnaUJd5CWKypyOduOMHKyPUbaaTTLZjl97mEH8QXLy3uSks28Bsjr7cu9WLT07vFiM/NZu1WCgvNBk=
Message-ID: <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
Date: Fri, 6 Jan 2006 18:49:55 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060106173547.GR12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060106173547.GR12131@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> Do not allow people to create configurations with CONFIG_BROKEN=y.
>
> The sole reason for CONFIG_BROKEN=y would be if you are working on
> fixing a broken driver, but in this case editing the Kconfig file is
> trivial.
>
> Never ever should a user enable CONFIG_BROKEN.
>
I disagree (slightly) with this patch for a few reasons:

- It's very convenient to be able to enable it through menuconfig.

- Being able to easily enable it in menuconfig, then browse through
the menus to look for something matching your hardware is nice, even
if that something is marked BROKEN at least you've then found a place
to start working on. A lot simpler than digging through directories.

- Some things marked BROKEN may not be 100% broken and may actually
work for some specific things, so if you know that it works for your
use, then being able to easily enable BROKEN and then whatever it is
you need is nice.

Perhaps just move it below the Kernel Hacking menu instead, users
don't go there (or if they do they damn well should know what they are
doing).

Ohh well, if it gets removed I won't really cry, but I do think it's
convenient, and if moved into Kernel Hacking it should be mostly out
of harms (read: users) way.


Just my 0.02euro


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

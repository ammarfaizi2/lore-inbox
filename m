Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWCFWKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWCFWKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWCFWKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:10:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932393AbWCFWKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:10:34 -0500
Date: Mon, 6 Mar 2006 14:08:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initcall at ... returned with error code -19 (Was: Re:
 2.6.16-rc5-mm2)
Message-Id: <20060306140851.4140ae2b.akpm@osdl.org>
In-Reply-To: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> On 3/3/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
> >
> 
> With this kernel I sometimes get :
>   initcall at 0xc0432790: rng_init+0x0/0xa0(): returned with error code -19
> and sometimes :
>   initcall at 0xc0428240: init_hpet_clocksource+0x0/0x90(): returned
> with error code -19
> 
> I haven't paid enough attention to be able to say if some boots had
> other variations, but at least the two above have been observed.
> 

That's OK - it's -ENODEV.  It's saying "hey, you linked this driver into
vmlinux but it didn't find any hardware to drive".

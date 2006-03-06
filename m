Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWCFWOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWCFWOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWCFWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:14:41 -0500
Received: from xenotime.net ([66.160.160.81]:38074 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932396AbWCFWOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:14:40 -0500
Date: Mon, 6 Mar 2006 14:16:08 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: initcall at ... returned with error code -19 (Was: Re:
 2.6.16-rc5-mm2)
Message-Id: <20060306141608.dfc4077e.rdunlap@xenotime.net>
In-Reply-To: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 22:59:56 +0100 Jesper Juhl wrote:

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
> 2.6.16-rc5-git8 is fine.

Andrew added some initcall error detection messages.
-19 is just -ENODEV.  No big deal except maybe the messages themselves. :)
You don't have a RNG or HPET device...

---
~Randy

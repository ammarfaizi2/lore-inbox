Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWGEXLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWGEXLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWGEXLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:11:35 -0400
Received: from xenotime.net ([66.160.160.81]:2981 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965009AbWGEXLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:11:35 -0400
Date: Wed, 5 Jul 2006 16:14:21 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: netconsole
Message-Id: <20060705161421.8eb00003.rdunlap@xenotime.net>
In-Reply-To: <5d96567b0607040143y3aa06c8cn1b6e591d1a3bdc31@mail.gmail.com>
References: <5d96567b0607040143y3aa06c8cn1b6e591d1a3bdc31@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 11:43:51 +0300 Raz Ben-Jehuda(caro) wrote:

> Matt hello
> I am testing netconsole.
> What i did is to create a panic driver.
> It is written bellow.
> Why I am not getting the panic output to netcat ?
> 
> thank you
> raz
> 
> 
> xxxxxxxxxxxxxxxxxxxxxxxxxxxx
> 
> #include <linux/module.h>
> #include <linux/fs.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> 
> static void do_panic_cleanup(void){}
> 
> static int do_panic_init(void){
>         panic("raz");
>         return -1;
> }
> module_init(do_panic_init);
> module_exit(do_panic_cleanup);
> 
> MODULE_DESCRIPTION("do panic");
> MODULE_AUTHOR("raz ben yehuda");
> MODULE_LICENSE("GPL");

Works for me.  I get this on the netconsole receiving system:

Kernel panic - not syncing: raz


---
~Randy

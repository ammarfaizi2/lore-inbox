Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSLQVIV>; Tue, 17 Dec 2002 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSLQVIV>; Tue, 17 Dec 2002 16:08:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4480 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265603AbSLQVIU>;
	Tue, 17 Dec 2002 16:08:20 -0500
Date: Tue, 17 Dec 2002 13:16:18 -0800
From: Bob Miller <rem@osdl.org>
To: rtilley <rtilley@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52 compile error
Message-ID: <20021217211618.GB1069@doc.pdx.osdl.net>
References: <3E058049@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E058049@zathras>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 03:57:01PM -0500, rtilley wrote:
> Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It keeps 
> returning this error on 2 totally different x86 PCs:
> 
> 
> drivers/built-in.o: In function `kd_nosound':
> drivers/built-in.o(.text+0x1883f): undefined reference to `input_event'
> drivers/built-in.o(.text+0x18861): undefined reference to `input_event'
> drivers/built-in.o: In function `kd_mksound':
> drivers/built-in.o(.text+0x1890a): undefined reference to `input_event'
> drivers/built-in.o: In function `kbd_bh':
> drivers/built-in.o(.text+0x197a2): undefined reference to `input_event'
> drivers/built-in.o(.text+0x197c1): undefined reference to `input_event'
> drivers/built-in.o(.text+0x197e0): more undefined references to `input_event' 
> follow
> drivers/built-in.o: In function `kbd_connect':
> drivers/built-in.o(.text+0x19d54): undefined reference to `input_open_device'
> drivers/built-in.o: In function `kbd_disconnect':
> drivers/built-in.o(.text+0x19d7f): undefined reference to `input_close_device'
> drivers/built-in.o: In function `kbd_init':
> drivers/built-in.o(.init.text+0x12c1): undefined reference to 
> `input_register_handler'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> Where is the fix for this?
> 
At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device support"
off the main page.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVADH4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVADH4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 02:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVADH4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 02:56:19 -0500
Received: from terminus.zytor.com ([209.128.68.124]:23993 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261548AbVADH4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 02:56:05 -0500
Message-ID: <41DA4BFB.7090800@zytor.com>
Date: Mon, 03 Jan 2005 23:55:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 boot loader IDs
References: <41D31696.8050701@zytor.com> <m1vfadr65h.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1vfadr65h.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> I suspect /sbin/kexec could use one.  But I don't have the faintest
> what you could do with the information after the kernel came up.
> 

Sounds incorrect, unless you're generating the zeropage information.

> I don't think enhancing the bootloader numeric parameter is the
> right way to go.  Currently the value is a single byte with the low
> nibble reserved for version number information.  With the
> values already assigned we have 7 left.  
> 
> If we assign a new value each for the bootloaders I know of that don't
> yet have values assigned: pxelinux, isolinux, filo, /sbin/kexec,
> redboot the pool of numbers is nearly exhausted.  With the addition of
> bootloaders I can't recall or have not been written yet we will
> quickly exhaust the pool of numbers.

pxelinux, isolinux and extlinux are syslinux derivatives (0x32, 0x33 and 
0x34 respectively.)  filo and redboot probably could use them, though.

> Even if using this mechanism is needed for supporting existing
> bootloaders I suggest it be deprecated in favor of a kernel command
> line option.  A command line option would be easier to maintain
> being string based.  It would be portable to architectures besides
> x86.  And it requires no additional code to implement, as you
> can already read /proc/cmdline.

Unfortunately the command line is very squeezed.  With the newer 
protocol we can probably support longer command lines, though.

It's a significant boot loader change, though.  In the short term it's 
definitely desirable to be able to read it.

	-hpa

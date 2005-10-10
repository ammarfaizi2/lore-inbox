Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVJJUhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVJJUhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVJJUhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:37:05 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:26559 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1751216AbVJJUhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:37:03 -0400
Message-ID: <434AD0EB.6000405@gmx.de>
Date: Mon, 10 Oct 2005 22:36:59 +0200
From: Georg Lippold <georg.lippold@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com> <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de> <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com> <434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de> <434A8D70.5060300@zytor.com> <20051010171605.GA7793@georg.homeunix.org> <434AB1EB.6070309@gmail.com>
In-Reply-To: <434AB1EB.6070309@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alon,

Alon Bar-Lev wrote:
> For boot protocol <2.02, the kernel command line is a null-terminated
> string up to 255 characters long, plus the final null. For boot protocol
>>=2.02 command line that is referred by cmd_line_ptr is null-terminated
> string, the kernel will truncate this string if it is too large to handle.

Thus, someone could use bootloaders to "patch" the kernel: If the
bootloader writes a string of arbitary length to some memory region,
then there is a fair chance that if you make the string just long
enough, the kernel image gets (partly) overwritten. It resembles a bit
"Smashing the stack for fun and profit", but this time, it's "Rewriting
the kernel to your own needs via the bootloader on x86" :)

Same thing for user defined COMMAND_LINE_SIZE. I think that a common
interface for boot loaders is required. Especially in uncontrolled multi
user environments like Universities, everything else could lead to
undesired results.

Greetings,

Georg

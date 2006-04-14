Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWDNR4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWDNR4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDNR4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:56:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17280 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751341AbWDNR4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:56:33 -0400
Message-ID: <443FE1AF.8050507@zytor.com>
Date: Fri, 14 Apr 2006 10:53:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <443EE4C3.5040409@gmail.com>
In-Reply-To: <443EE4C3.5040409@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> diff -urNp linux-2.6.16/Documentation/i386/boot.txt linux-2.6.16.new/Documentation/i386/boot.txt
> --- linux-2.6.16/Documentation/i386/boot.txt	2006-03-20 07:53:29.000000000 +0200
> +++ linux-2.6.16.new/Documentation/i386/boot.txt	2006-04-14 01:55:47.000000000 +0300
> @@ -235,11 +235,8 @@ loader to communicate with the kernel.  
>  relevant to the boot loader itself, see "special command line options"
>  below.
>  
> -The kernel command line is a null-terminated string currently up to
> -255 characters long, plus the final null.  A string that is too long
> -will be automatically truncated by the kernel, a boot loader may allow
> -a longer command line to be passed to permit future kernels to extend
> -this limit.
> +The kernel command line is a null-terminated string. A string that is too
> +long will be automatically truncated by the kernel.
>  
>  If the boot protocol version is 2.02 or later, the address of the
>  kernel command line is given by the header field cmd_line_ptr (see
> @@ -260,6 +257,9 @@ command line is entered using the follow
>  	covered by setup_move_size, so you may need to adjust this
>  	field.
>  
> +       The kernel command line *must* be 256 bytes including the
> +       final null.
> +
>  
>  **** SAMPLE BOOT CONFIGURATION
>  

This chunk is confusing at the very best.

	-hpa

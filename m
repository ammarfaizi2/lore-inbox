Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUKGVQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUKGVQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUKGVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:16:17 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:60117 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261683AbUKGVP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:15:56 -0500
Message-ID: <418E9088.7060709@myrealbox.com>
Date: Sun, 07 Nov 2004 13:15:52 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041107)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit segfaults on x86_64 in recent mm kernels
References: <418E8759.9070408@myrealbox.com>
In-Reply-To: <418E8759.9070408@myrealbox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> I've had segfaults in 32-bit emulation in recent (and not-so-recent) -mm
> kernels on x86_64.
> 
> 2.6.7-gentoo-r11 and 2.6.10-rc1 both work fine (even wine works for the 
> most part).
> 
> 2.6.9-rc3-mm3 can't run wine -- it always segfaults.  Other apps seem OK.
> 
> 2.6.10-rc1-mm1 can't run anything -- even this segfaults (compiled with 
> both
> 'gcc -o foo -m32 foo.c' and 'gcc -o foo -m32 -Wl,-zexecstack foo.c'):
> 
> #include <stdio.h>
> 
> int main()
> {
>        printf("Hello %d\n", (int)(sizeof(int*)));
>        return 0;
> }
> 
> Sorry, no debug info, since debugging tools segfault too.
> 
> This is my syslog for 2.6.10-rc1-mm1, with some userspace stuff stripped:

s/2.6.10-rc1-mm1/2.6.10-rc1-mm3/g, obviously.

> 
> Nov  7 08:37:41 luto Linux version 2.6.10-rc1-mm3 

etc.

--Andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVJNFox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVJNFox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 01:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJNFox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 01:44:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:14778 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932178AbVJNFox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 01:44:53 -0400
Date: Fri, 14 Oct 2005 07:45:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Singleton <dsingleton@mvista.com>
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Robust Futex update
Message-ID: <20051014054522.GA22749@elte.hu>
References: <434DA382.1050100@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434DA382.1050100@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Singleton <dsingleton@mvista.com> wrote:

> Index: linux-2.6.13/include/linux/futex.h
> ===================================================================
> --- linux-2.6.13.orig/include/linux/futex.h
> +++ linux-2.6.13/include/linux/futex.h
> @@ -1,8 +1,6 @@
>  #ifndef _LINUX_FUTEX_H
>  #define _LINUX_FUTEX_H
>  
> -#include <linux/fs.h>
> -
>  /* Second argument to futex syscall */
>  

this chunk broke the build, so i added the #include back. Really, the 
robust mutex glibc patches should _NOT_ automatically include the 
kernel's futex.h file. If they do so and rely on an installed 
kernel-headers package then they are broken. Just copy the file into the 
glibc tree and remove the #include line.

	Ingo

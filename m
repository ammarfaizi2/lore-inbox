Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVFHR0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVFHR0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVFHRXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:23:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:31714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261452AbVFHRXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:23:11 -0400
Date: Wed, 8 Jun 2005 10:24:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org,
       jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
In-Reply-To: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Jun 2005, Paul Mackerras wrote:
> 
> * uname(2) doesn't respect PER_LINUX32, it returns 'ppc64' instead of 'ppc'

I think this is a feature, not a bug, and I suspect you just broke
compiling a 64-bit kernel by default on ppc64.

Dammit, the system _is_ ppc64. The fact that the uname binary is not is
neither here nor there. It's like x86 that reports i386/i486/.. depending 
on what the machine is. If uname wants to make it clear that uname has 
been compiled for 32-bit ppc, then it can damn well output "ppc" on its 
own without asking the kernel what the kernel is.

		Linus

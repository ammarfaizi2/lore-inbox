Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbUKSBd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbUKSBd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUKSBdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:33:51 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:20606 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263043AbUKSBbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:31:17 -0500
Message-ID: <6599ad8304111817317880dfe5@mail.google.com>
Date: Thu, 18 Nov 2004 17:31:14 -0800
From: Paul Menage <menage@google.com>
Reply-To: Paul Menage <menage@google.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [discuss] RFC: let x86_64 no longer define X86
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041119005117.GM4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041119005117.GM4943@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004 01:51:17 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> I'd like to send a patch after 2.6.10 that removes the following from
> arch/x86_64/Kconfig:
> 
>   config X86
>         bool
>         default y
> 
> Additionally, I'll also check all current X86 uses to prevent breakages.
> 

Or, you could define an X86_32 config symbol in i386. This seems a
little more backward compatible, and means that you can continue to
just test X86 for the rather large set of code that works fine on both
32-bit and 64-bit.

I guess it depends on whether you think there are more places in the
generic code that the two architectures share code, vs places that are
32-bit only.

Paul

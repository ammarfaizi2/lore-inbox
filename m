Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVKPNN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVKPNN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVKPNN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:13:27 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:47582
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S965251AbVKPNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:13:26 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
Date: Wed, 16 Nov 2005 07:13:07 -0600
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <8.282480653@selenic.com>
In-Reply-To: <8.282480653@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160713.07632.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 02:35, Matt Mackall wrote:
> This adds configurable support for doublefault reporting on x86
...
> +config DOUBLEFAULT
> + depends X86
> + default y if X86
> + bool "Enable doublefault exception handler" if EMBEDDED
> + help
> +          This option allows trapping of rare doublefault exceptions that
> +          would otherwise cause a system to silently reboot. Disabling
> this +          option saves about 4k.
> +

What causes doublefaults?  Is it triggerable from userspace, or is it 
something funky the kernel does?

Trying to figure out when it would be worth using this...

Rob

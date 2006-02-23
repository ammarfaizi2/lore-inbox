Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWBWBDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWBWBDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWBWBDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:03:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55708
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751481AbWBWBDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:03:47 -0500
Date: Wed, 22 Feb 2006 17:03:44 -0800 (PST)
Message-Id: <20060222.170344.84235860.davem@davemloft.net>
To: hpa@zytor.com
Cc: bcrl@kvack.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43FD08D8.70300@zytor.com>
References: <20060223001411.GA20487@kvack.org>
	<20060222.164347.12864037.davem@davemloft.net>
	<43FD08D8.70300@zytor.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 22 Feb 2006 16:59:04 -0800

> On the other hand, sys32_mmap2 on SPARC64 matches the SPARC32 sys_mmap2 
> in that the shift is hard-coded to 12:
> 
>          .globl          sys32_mmap2
> sys32_mmap2:
>          sethi           %hi(sys_mmap), %g1
>          jmpl            %g1 + %lo(sys_mmap), %g0
>           sllx           %o5, 12, %o5

Another good catch...

> At this point, I'm more than willing to treat SPARC as a special case, 
> but I really want to know what the rules actually _ARE_ as opposed to 
> what they are supposed to be (which they clearly are not.)

I have to admit I'm totally stumped...

Why are you invoking mmap2() instead of mmap64() btw?

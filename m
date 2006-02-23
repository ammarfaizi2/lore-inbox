Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWBWAns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWBWAns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWBWAns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:43:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38540
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030339AbWBWAnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:43:47 -0500
Date: Wed, 22 Feb 2006 16:43:47 -0800 (PST)
Message-Id: <20060222.164347.12864037.davem@davemloft.net>
To: bcrl@kvack.org
Cc: hpa@zytor.com, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060223001411.GA20487@kvack.org>
References: <43FCDB8A.5060100@zytor.com>
	<20060223001411.GA20487@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Wed, 22 Feb 2006 19:14:11 -0500

> The sys_mmap2() ABI is that the page shift is always fixed to whatever 
> page size is reasonable for the architecture, typically 2^12.  The syscall 
> should never be exposed as mmap2(), only as the large file size version 
> of mmap() (aka mmap64()).  The other consideration is that it should not 
> be implemented in 64 bit ABIs, as those machines should be using a 64 bit 
> native mmap().  Does that clear things up a bit?  Cheers,

Aha, that part I didn't catch.  Thanks for the clarification
Ben.

I wonder why we did things that way with a fixed shift...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbVKWW4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVKWW4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKWW4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:56:06 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:46512 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S1030467AbVKWW4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:56:04 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual opteron various segfaults with 2.6.14.2 and earlier kernels
Date: Wed, 23 Nov 2005 22:55:57 +0000
User-Agent: KMail/1.8.2
References: <200511231537.49320.cova@ferrara.linux.it>
In-Reply-To: <200511231537.49320.cova@ferrara.linux.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232255.57716.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 14:37, Fabio Coatti wrote:
> Hi all,
> I'm seeing several segfaults on a couple of HP DL585 Dual Opterons, 8Gb ram
> each.
>
> The segfaults are like this:
> factorial[17031]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> 00007fffffe287e0 error 4
> factorial[17034]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> 00007fffffc6f450 error 4
> factorial[17038]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> 00007fffffdbd060 error 4
> factorial[17044]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> 00007fffffb48fa0 error 4
> factorial[17046]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> 00007fffffc2a7f0 error 4
> ld[3997]: segfault at 0000000000000020 rip 00002aaaaad1a525 rsp
> 00007fffffa8e960 error 4
> ld[4234]: segfault at 0000000000000020 rip 00002aaaaad1a525 rsp
> 00007fffffc3a1e0 error 4
>
> This is only an example; often during some "make", also sed segfaults (!).
> I've seen this with 2.6.12, 2.6.13.4, 2.6.14.2
>

The symtoms look just like the TLB flush filter errata which affected SMP 
x86_64 kernels upto (at least) 2.6.13.4. IIRC it was fixed for 2.6.14 (at 
least I stopped using the patch after 2.6.13.4).

Are you sure you saw this with 2.6.14+ ?

Andrew Walrond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTEVDpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 23:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTEVDpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 23:45:03 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55937 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262470AbTEVDpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 23:45:02 -0400
Date: Wed, 21 May 2003 20:57:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Gerrit Huizenga <gh@us.ibm.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <60830000.1053575867@[10.10.2.4]>
In-Reply-To: <20030522020443.GN2444@holomorphy.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> <E19Idxq-0001LD-00@w-gerrit2> <20030522020443.GN2444@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The task scheduler, the io scheduler, and memory entitlement policies
> are very different issues. They deal entirely with managing software
> constructs and resource allocation. 

So we should expose low-level hardware stuff to userspace to manage, 
but not higher level software constructs? I fail to see the abiding 
logic there. If anything, the inverse ought to be true.

> IMHO Linux on Pentium IV should use the TPR in conjunction with _very_
> simplistic interrupt load accounting by default and all more
> sophisticated logic should be punted straight to userspace as an
> administrative API.

I'd be happy with that - sounds to me like you're arguing for the same 
thing. Sane default in kernel, can override from userspace if you like. 
However, I've yet to see an implementation of the TPR usage that got
good performance numbers ... I'd love to see that happen.

M.

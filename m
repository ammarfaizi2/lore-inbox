Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWEJKMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWEJKMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWEJKMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:12:13 -0400
Received: from mail.suse.de ([195.135.220.2]:16045 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750915AbWEJKML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:12:11 -0400
From: Andi Kleen <ak@suse.de>
To: "bibo,mao" <bibo_mao@linux.intel.com>
Subject: Re: [PATCH]x86_64 debug_stack nested patch
Date: Wed, 10 May 2006 12:12:06 +0200
User-Agent: KMail/1.9.1
Cc: Jan Beulich <jbeulich@novell.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       mao bibo <bibo.mao@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <44618C0D.6020604@intel.com> <4461B8B0.76E4.0078.0@novell.com> <4461A3B2.8000601@linux.intel.com>
In-Reply-To: <4461A3B2.8000601@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605101212.06854.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 10:26, bibo,mao wrote:
> yes, I am wrong. And I will modify this. And then only need define 
> DEBUG_STACK_ORDER as (EXCEPTION_STACK_ORDER + 1)

If the kprobes code really wants to nest (in my opinion it's a kprobes
bug) you should reduce its stack to 2K or so. Don't want to waste 
space for stupid code like this.

-Andi


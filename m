Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWG2QcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWG2QcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWG2Qb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:12491 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932153AbWG2Qbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:31:51 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, kmannth@us.ibm.com
Subject: Re: [discuss] [Patch] 4/5 in support of hot-add memory x86_64 fix kernel mapping code
Date: Sat, 29 Jul 2006 18:32:09 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, andrew <akpm@osdl.org>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>,
       dave hansen <haveblue@us.ibm.com>, konrad <darnok@us.ibm.com>
References: <1154141570.5874.148.camel@keithlap>
In-Reply-To: <1154141570.5874.148.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291832.09995.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 04:52, keith mannthey wrote:
> Hello All,
>
>   phys_pud_init is broken when using it at runtime with some offsets.
> It currently only maps one pud entry worth of pages while trampling any
> mappings that may have existed on the pmd_page :(

To print x86-64 ptes you need a %016lx (or just %lx) 

it would be cleaner to recompute pmd inside the loop based on i
and use a standard for() 

It is unclear why you hardcode 0 as address in phys_pmd_update
when a real address is passed in?

-Andi


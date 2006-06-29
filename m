Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWF2Unj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWF2Unj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWF2Unj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:43:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932470AbWF2Unh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:43:37 -0400
Date: Thu, 29 Jun 2006 16:43:30 -0400
From: Dave Jones <davej@redhat.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-ID: <20060629204330.GC13619@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060629013643.4b47e8bd.akpm@osdl.org> <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 10:39:33PM +0200, Michal Piotrowski wrote:

 > This looks very strange.
 > 
 > BUG: unable to handle kernel paging request at virtual address 6b6b6c07

Looks like a use after free.

 > printing eip:
 > c0138594
 > *pde=00000000
 > Oops: 0002 [#1]
 > 4K_STACK PREEMPT SMP
 > last sysfs file /class/net/eth0/address
 > Modules linked in: ipv6 af_packet ipt_REJECT xt_tcpudp x_tables
 > p4_clockmod speedstep_lib binfmt_misc
 > 
 > (gdb) list *0xc0138594
 > 0xc0138594 is in __lock_acquire (include2/asm/atomic.h:96).
 > warning: Source file is more recent than executable.

got a backtrace ?

		Dave

-- 
http://www.codemonkey.org.uk

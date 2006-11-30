Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759223AbWK3JYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759223AbWK3JYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759222AbWK3JYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:24:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30919 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1759218AbWK3JYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:24:15 -0500
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
From: Ingo Molnar <mingo@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
In-Reply-To: <20061129235407.7295c31d.akpm@osdl.org>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
	 <20061129174558.3dfd13df.akpm@osdl.org> <1164870000.11036.23.camel@earth>
	 <20061129235407.7295c31d.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 10:22:20 +0100
Message-Id: <1164878540.11036.29.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 23:54 -0800, Andrew Morton wrote:
> which is somewhat unpleasant.  I added a WARN_ON(irqs_disabled()) to
> the
> out-of-line SMP version.

ok.
> 
> btw, does anyone know why the SMP versions of this function use
> spin_lock_bh(&call_lock)?

that makes no sense (neither the get_cpu()/put_cpu() gymnastics) if this
is called with irqs disabled all the time.

	Ingo
> 


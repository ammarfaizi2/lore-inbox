Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWJEPcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWJEPcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWJEPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:32:16 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15517 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751018AbWJEPcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:32:14 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Martin Bligh <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1160061173.9569.43.camel@dyn9047017100.beaverton.ibm.com>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20061004170659.f3b089a8.akpm@osdl.org> <20061005005124.GA23408@in.ibm.com>
	 <200610050257.53971.ak@suse.de>  <45245B03.2070803@mbligh.org>
	 <1160060020.29690.5.camel@flooterbu>
	 <1160061173.9569.43.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 10:32:11 -0500
Message-Id: <1160062332.29690.10.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 08:12 -0700, Badari Pulavarty wrote:

> Can you post the latest panic stack again (with CONFIG_DEBUG_KERNEL) ? 

CONFIG_DEBUG_KERNEL should be on

> Last time I couldn't match your instruction dump to any code segment
> in the routine. And also, can you post your .config file. I have
> an amd64 and em64t machine and both work fine...

Unable to handle kernel NULL pointer dereference at 0000000000000827 RIP:
 [<ffffffff804705e6>] xfrm_register_mode+0x36/0x60
PGD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.18-git22 #1
RIP: 0010:[<ffffffff804705e6>]  [<ffffffff804705e6>] xfrm_register_mode+0x36/0x60
RSP: 0000:ffff810bffcbded0  EFLAGS: 00010286
RAX: 000000000000081f RBX: ffffffff805588a0 RCX: 0000000000000000
RDX: ffffffffffffffff RSI: 0000000000000002 RDI: ffffffff80559550
RBP: 00000000ffffffef R08: 000000003f924371 R09: 0000000000000000
R10: ffff810bffcbdcb0 R11: 0000000000000154 R12: 0000000000000000
R13: ffff810bffcbdef0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff805d2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000827 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff810bffcbc000, task ffff810bffcbb4e0)
Stack:  0000000000000000 ffffffff8061fb48 0000000000000000 ffffffff80207182
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000090000

The base config file I'm using is at
http://flooterbu.net/kernel/elm3b239-2.6.17.config

-- 

Steve Fox
IBM Linux Technology Center

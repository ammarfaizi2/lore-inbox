Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269400AbUJFQ5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbUJFQ5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUJFQxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:53:33 -0400
Received: from mail.optivus.com ([4.36.236.162]:50905 "EHLO pogo1.optivus.com")
	by vger.kernel.org with ESMTP id S268838AbUJFQuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:50:40 -0400
From: Michael Baumann <baumann@optivus.com>
Reply-To: baumann@optivus.com
Organization: Optivus Technology, Inc.
To: linux-kernel@vger.kernel.org
Subject: Problem trying to implement mmap for device on 2.4
Date: Wed, 6 Oct 2004 09:50:39 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410060950.39483.baumann@optivus.com>
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-1.4 (pogo1.optivus.com [143.197.200.253]); Wed, 06 Oct 2004 09:50:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is too much of a noob question - do point me to the right place
if you can.
System: PPC on VME
Attempting driver for 3rd party NVRAM board - it's meant to be used as
a data-store/system-state recorder. Will be used by more than one
processor in the system - each processor is to use a "chunk" of the RAM
as it's scratch space. Or that's the plan.

Based on what I thought I understood from Rubini&Corbet 2nd Edition
I created a simple module, that provided a mmap method - after reserving
the region via request_mem_region.

mapping was done with a simple remap_page_range() 

In userland, the mmap system call is made, with MAP_FIXED
and the kernel immediately fails the call with "cannot allocate memory" - 
never even getting to my implementation of the mmap call. Apparently
dying somewhere during "the good deal of work" Rubini talks about.
If I don't use MAP_FIXED, things 'work', but I need that fixed location,
I'm obviously trying to map the RAM into user space for access.


I'm assuming I'm missing something simple in the setup, somewhere.
Any help/pointers/ even insults accepted - I'm in a tough spot here.

 
-- 
--
#include <std_disclaimer>
Michael Baumann   9518974841
Optivus Technology, Inc.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTEVS0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTEVS0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:26:31 -0400
Received: from palrel10.hp.com ([156.153.255.245]:57017 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263084AbTEVS03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:26:29 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.6500.502815.97688@napali.hpl.hp.com>
Date: Thu, 22 May 2003 11:39:32 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@digeo.com>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       David Mosberger-Tang <davidm@hpl.hp.com>
Subject: Re: [PATCH] per-cpu support inside modules (minimal)
In-Reply-To: <20030522100511.751E02C0F1@lists.samba.org>
References: <20030522100511.751E02C0F1@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Rusty> OK, this does the *minimum* required to support
  Rusty> DEFINE_PER_CPU inside modules.  If we decide to change
  Rusty> kmalloc_percpu later, great, we can turf this out.

  Rusty> Basically, overallocates the amount of per-cpu data at boot
  Rusty> to at least PERCPU_ENOUGH_ROOM if CONFIG_MODULES=y
  Rusty> (arch-specific by default 16k: I have only 5700 bytes of
  Rusty> percpu data in my kernel here, so makes sense), and a special
  Rusty> allocator in module.c dishes it out.

  Rusty> Comments welcome!

Looks good to me.  For ia64, I guess I'll want to add a

	#define PERCPU_ENOUGH_ROOM	PERCPU_PAGE_SIZE

somewhere, but that doesn't sound so hard. ;-)

Thanks!

	--david

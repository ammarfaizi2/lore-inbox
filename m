Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTEFFLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTEFFLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:11:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45028 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262369AbTEFFLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:11:00 -0400
Date: Mon, 05 May 2003 21:16:06 -0700 (PDT)
Message-Id: <20030505.211606.28803580.davem@redhat.com>
To: akpm@digeo.com
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030505220250.213417f6.akpm@digeo.com>
References: <20030506040856.8B3712C36E@lists.samba.org>
	<20030505.204002.08338116.davem@redhat.com>
	<20030505220250.213417f6.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Mon, 5 May 2003 22:02:50 -0700

   "David S. Miller" <davem@redhat.com> wrote:
   > Andrew's example with some module doing kmalloc_percpu() inside
   > of fops->open() is just rediculious.
   
   crap.  Modules deal with per-device and per-mount objects.  If a module
   cannot use kmalloc_per_cpu on behalf of the primary object which it manages
   then the facility is simply not useful to modules.

Ok then.

Please address the ia64 concerns then :-)  It probably means we
have to stay with the dereferencing stuff...  at which point you
might as well use normal kmalloc() and smp_processor_id() indexing
inside of modules.

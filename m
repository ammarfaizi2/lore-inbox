Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTEFHKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTEFHKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:10:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262427AbTEFHKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:10:49 -0400
Date: Mon, 05 May 2003 23:15:53 -0700 (PDT)
Message-Id: <20030505.231553.68055974.davem@redhat.com>
To: akpm@digeo.com
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030506002229.631a642a.akpm@digeo.com>
References: <20030505235549.5df75866.akpm@digeo.com>
	<20030505.225748.35026531.davem@redhat.com>
	<20030506002229.631a642a.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Tue, 6 May 2003 00:22:29 -0700

   "David S. Miller" <davem@redhat.com> wrote:
   >
   > Make kmalloc_per_cpu() merely a convenience macro, made up of existing
   > non-percpu primitives.
   
   I think we're agreeing here.
   
As just pointed out by dipankar the only issue is NUMA...
so it has to be something more sophisticated than simply
kmalloc()[smp_processor_id];

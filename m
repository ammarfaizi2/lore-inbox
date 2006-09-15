Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWIOUCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWIOUCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWIOUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:02:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25796 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751669AbWIOUCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:02:30 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060915183432.GJ4577@redhat.com>
References: <20060915183432.GJ4577@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 21:25:51 +0100
Message-Id: <1158351951.29932.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 14:34 -0400, ysgrifennodd Frank Ch. Eigler:
> locations, but this is self-modifying code involving multiple
> instructions, and appears to be tricky on SMP/preempt boxes.

Can you explain more about why this is the case. I would have though
that it's the same with one instruction or 100 to the non SMP case. You
may never patch an instruction while another CPU may be executing that
path and there must be a synchronizing point for each CPU before it hits
the patched instruction. See the Intel and AMD chip errata documents.

Figuring out how long to patch is a more complicated problem but there
is extant code to compute the length of an x86 instruction.


Alan


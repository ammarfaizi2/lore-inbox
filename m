Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUCZVMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUCZVMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:12:38 -0500
Received: from palrel13.hp.com ([156.153.255.238]:46208 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264134AbUCZVMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:12:36 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16484.40129.606865.830739@napali.hpl.hp.com>
Date: Fri, 26 Mar 2004 13:12:33 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, davej@redhat.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040326123303.7a775b02.akpm@osdl.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
	<16484.29095.842735.102236@napali.hpl.hp.com>
	<20040326104904.59f7a156.akpm@osdl.org>
	<16484.37279.839961.375027@napali.hpl.hp.com>
	<20040326123303.7a775b02.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Mar 2004 12:33:03 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> If someone does, say,

  Andrew> 	prefetch_range(some_pointer, sizeof(*some_pointer));

  Andrew> then it is possible that prefetch_range() could

  Andrew> a) execute a prefetch at addresses which are not
  Andrew> PREFETCH_STRIDE-aligned and, as a consequence,

  Andrew> b) prefetch data from the next page, outside the range of
  Andrew> the user's (addr,len).

This is getting silly.  Cache-lines _never_ cross page-boundaries.

	--david

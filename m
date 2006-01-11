Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWAKXrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWAKXrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbWAKXrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:47:01 -0500
Received: from fmr22.intel.com ([143.183.121.14]:19427 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964773AbWAKXqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:46:45 -0500
Message-Id: <200601112346.k0BNk5g02008@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
Date: Wed, 11 Jan 2006 15:46:05 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYXA5Czwn9PohthTzqItiwomjgCdAABRQKg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1137020606.9672.16.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Wednesday, January 11, 2006 3:03 PM
> Nope, all the i_blocks stuff is gone.  I was just looking for a
> spin_lock for serializing all allocations for a particular hugeltbfs
> file and i_lock seemed to fit that bill.

I hope you are aware of the consequence of serializing page allocation:
It won't scale on large numa machine.  I don't have any issue per se at
the moment.  But in the past, SGI folks had screamed their heads off
for people doing something like that.

- Ken


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268602AbTCCVmh>; Mon, 3 Mar 2003 16:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268603AbTCCVmg>; Mon, 3 Mar 2003 16:42:36 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:32103 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268602AbTCCVmd>; Mon, 3 Mar 2003 16:42:33 -0500
Date: Mon, 03 Mar 2003 15:52:42 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2.5.63] Teach page_mapped about the anon flag
Message-ID: <117290000.1046728362@baldur.austin.ibm.com>
In-Reply-To: <20030303133539.6594e0b6.akpm@digeo.com>
References: <20030227025900.1205425a.akpm@digeo.com>
 <200302280822.09409.kernel@kolivas.org>
 <20030227134403.776bf2e3.akpm@digeo.com>
 <118810000.1046383273@baldur.austin.ibm.com>
 <20030227142450.1c6a6b72.akpm@digeo.com>
 <103400000.1046725581@baldur.austin.ibm.com>
 <20030303131210.36645af6.akpm@digeo.com>
 <107610000.1046726685@baldur.austin.ibm.com>
 <20030303133539.6594e0b6.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, March 03, 2003 13:35:39 -0800 Andrew Morton <akpm@digeo.com>
wrote:

> We do need a patch I think.  page_mapped() is still assuming that an
> all-bits-zero atomic_t corresponds to a zero-value atomic_t.
> 
> This does appear to be true for all supported architectures, but it's a
> bit grubby.

If that's ever not true then we need extra code to initialize/rezero that
field, since we assume it's zero on alloc, and the pte_chain code also
assumes it's zero for a new page.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268814AbTCCVOc>; Mon, 3 Mar 2003 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268815AbTCCVOc>; Mon, 3 Mar 2003 16:14:32 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:50880 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268814AbTCCVOb>; Mon, 3 Mar 2003 16:14:31 -0500
Date: Mon, 03 Mar 2003 15:24:45 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2.5.63] Teach page_mapped about the anon flag
Message-ID: <107610000.1046726685@baldur.austin.ibm.com>
In-Reply-To: <20030303131210.36645af6.akpm@digeo.com>
References: <20030227025900.1205425a.akpm@digeo.com>
 <200302280822.09409.kernel@kolivas.org>
 <20030227134403.776bf2e3.akpm@digeo.com>
 <118810000.1046383273@baldur.austin.ibm.com>
 <20030227142450.1c6a6b72.akpm@digeo.com>
 <103400000.1046725581@baldur.austin.ibm.com>
 <20030303131210.36645af6.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, March 03, 2003 13:12:10 -0800 Andrew Morton <akpm@digeo.com>
wrote:

> It is.  All callers which need to be 100% accurate are under
> pte_chain_lock().

Hmm, good point.  Some places may not need perfect accuracy.  Also, if it
gives a false positive it means someone else is doing an atomic op on it,
so it's likely to be in transition to/from true anyway.

Ok, you've convinced me.  Please ignore the patch.  I'll hang onto it in
case we get proved wrong at some point.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


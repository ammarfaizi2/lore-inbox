Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbTDCQ21>; Thu, 3 Apr 2003 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbTDCQ20>; Thu, 3 Apr 2003 11:28:26 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56852 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261357AbTDCQ20>; Thu, 3 Apr 2003 11:28:26 -0500
Date: Thu, 03 Apr 2003 10:39:37 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-ID: <23590000.1049387977@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0304031727420.2014-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304031727420.2014-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, April 03, 2003 17:33:31 +0100 Hugh Dickins
<hugh@veritas.com> wrote:

> No: see the various checks on page_count(page) in vmscan.c:
> though page_convert_anon temporarily leaves a page with neither
> mapcount nor the right number of pte pointers, page_count is unaffected.

Oh, hmm... Ok, so it's safe... This could have some interesting
implications all around.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


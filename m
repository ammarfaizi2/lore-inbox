Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTDCUui 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263466AbTDCUui 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:50:38 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:11449 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263464AbTDCUuh 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:50:37 -0500
Date: Thu, 03 Apr 2003 15:01:53 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-ID: <51190000.1049403713@baldur.austin.ibm.com>
In-Reply-To: <20030403125634.5afa54fb.akpm@digeo.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
 <20030402132939.647c74a6.akpm@digeo.com>
 <80300000.1049320593@baldur.austin.ibm.com>
 <20030402150903.21765844.akpm@digeo.com>
 <102170000.1049325787@baldur.austin.ibm.com>
 <20030402153845.0770ef54.akpm@digeo.com>
 <110950000.1049326945@baldur.austin.ibm.com>
 <20030402155220.651a1005.akpm@digeo.com>
 <116640000.1049327888@baldur.austin.ibm.com><92070000.1049381395@[10.1.1.5]>
 <20030403120611.6691399e.akpm@digeo.com>
 <20030403125634.5afa54fb.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, April 03, 2003 12:56:34 -0800 Andrew Morton <akpm@digeo.com>
wrote:

> Complete bollocks.  As long as the pte chains are consistent while
> refill_inactive_zone holds pte_chain_lock (they darn well should be),
> concurrent page_referenced() and page_convert_anon() is fine.

Good.  You just saved me from having to butcher refill_inactive_zone :)

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


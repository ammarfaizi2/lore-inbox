Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWC2Gpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWC2Gpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC2Gpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:45:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:28092 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751092AbWC2Gpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:45:41 -0500
X-IronPort-AV: i="4.03,141,1141632000"; 
   d="scan'208"; a="16944142:sNHT23364852"
Message-Id: <200603290645.k2T6jbg03728@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Christoph Lameter" <clameter@sgi.com>
Cc: "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Tue, 28 Mar 2006 22:46:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZS7Z6GV0Ex2LG7QaGE7pL7Z0DCxQADDzMw
In-Reply-To: <4429F27C.6020404@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 28, 2006 6:36 PM
> Hmm, not sure. Maybe a few new bitops with _lock / _unlock postfixes?
> For page lock and buffer lock we'd just need test_and_set_bit_lock,
> clear_bit_unlock, smp_mb__after_clear_bit_unlock.
> 
> I don't know, _for_lock might be a better name. But it's getting long.

I think kernel needs all 4 variants:

clear_bit
clear_bit_lock
clear_bit_unlock
clear_bit_fence

And the variant need to permutated on all other bit ops ...  I think it
would be indeed a better API and be more explicit about the ordering.

- Ken

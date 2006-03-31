Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWCaBMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWCaBMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWCaBMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:12:54 -0500
Received: from mga03.intel.com ([143.182.124.21]:63154 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751078AbWCaBMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:12:53 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17153827:sNHT52341387"
Message-Id: <200603310112.k2V1Cpg27150@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 17:13:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUX97hQI02AVNuRMGqurYY24wRCQAADY8g
In-Reply-To: <Pine.LNX.4.64.0603301707300.2553@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 5:09 PM
> In general yes the caller should not be thinking about clear_bit having 
> any memory ordering at all. However for IA64 arch specific code the bit 
> operations must have a certain ordering semantic and it would be best that 
> these are also consistent. clear_bit is not a lock operation and may 
> f.e. be used for locking something.

OK, fine.  Then please don't change smp_mb__after_clear_bit() for ia64.
i.e., leave it alone as noop.

- Ken

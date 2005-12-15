Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVLORYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVLORYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVLORYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:24:24 -0500
Received: from fmr22.intel.com ([143.183.121.14]:2220 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750821AbVLORYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:24:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
Date: Thu, 15 Dec 2005 09:24:03 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0535A4DC@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
Thread-Index: AcYBhDxpstz8eCotTbeskxO3L0KbUQAF5OQw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Benjamin LaHaise" <bcrl@kvack.org>,
       "Kenji Kaneshige" <kaneshige.kenji@jp.fujitsu.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Yasunori Goto" <y-goto@jp.fujitsu.com>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <linux-mm@kvack.org>
X-OriginalArrivalTime: 15 Dec 2005 17:24:05.0044 (UTC) FILETIME=[593E9F40:01C6019C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 15, 2005 at 02:24:29PM +0900, Kenji Kaneshige wrote:
> > How about this?
> 
> Excellent!  Thanks Kenji.  Tony, are you okay with this patch going in?

It is a bit annoying to have to add an argument that is never
used to local_flush_tlb_all() just to make the compiler make
the right code when we want to use in with on_each_cpu().  But
I don't see a better way.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony

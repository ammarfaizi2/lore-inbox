Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUCCRIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 12:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUCCRIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 12:08:52 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:10144 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262521AbUCCRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 12:08:51 -0500
Date: Wed, 03 Mar 2004 11:07:39 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <10500000.1078333658@[10.1.1.4]>
In-Reply-To: <20040303165746.GO4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random>
 <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]>
 <20040303165746.GO4922@dualathlon.random>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, March 03, 2004 17:57:46 +0100 Andrea Arcangeli
<andrea@suse.de> wrote:

>> There was talk at one point of moving the "unswappable" state down into 
>> the struct page. Is that still realistic? It would seem rather more
>> efficient, but I forget what problem we ran into with it.
> 
> that already exists and it's PG_reserved, but it's inefficient compared
> to VM_RESERVED, since it forces the vm to check all ptes.

What we've actually discussed before was more along the lines of PG_locked
to match VM_LOCKED, but the main idea was to be able to skip over
ineligible pages without having ot look up their mappings during pageout.

Dave McCracken


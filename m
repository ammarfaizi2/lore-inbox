Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbULMWXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbULMWXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbULMWWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:22:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2515 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261205AbULMWQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:16:49 -0500
Date: Mon, 13 Dec 2004 14:16:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Lameter <clameter@sgi.com>, Akinobu Mita <amgta@yacht.ocn.ne.jp>
cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Message-ID: <8880000.1102976179@flay>
In-Reply-To: <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain><156610000.1102546207@flay> <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com><200412132330.23893.amgta@yacht.ocn.ne.jp> <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I also encountered processes segfault.
>> Below patch fix several problems.
>> 
>> 1) if no pages could allocated, returns VM_FAULT_OOM
>> 2) fix duplicated pte_offset_map() call
> 
> I also saw these two issues and I think I dealt with them in a forthcoming
> patch.
> 
>> 3) don't set_pte() for the entry which already have been set
> 
> Not sure how this could have happened in the patch.
> 
> Could you try my updated version:

Urgle. There was a fix from Hugh too ... any chance you could just stick
a whole new patch somewhere? I'm too idle/stupid to work it out ;-)

M.


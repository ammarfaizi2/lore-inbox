Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTKNVsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTKNVsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:48:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:48364 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264387AbTKNVsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:48:01 -0500
Date: Fri, 14 Nov 2003 13:47:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.6.0-test9-mm3
In-Reply-To: <103290000.1068847073@flay>
Message-ID: <Pine.LNX.4.44.0311141344290.5877-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Nov 2003, Martin J. Bligh wrote:
> 
> Linus had some debug thing for triple faults, a few months ago, IIRC ...
> probably in the archives somewhere ...

Triple faults you can't debug, they raise a line outside the CPU, and 
normal PC hardware will cause that to just trigger a reboot.

But double faults do get caught, and that debugging stuff actually is in
the standard kernel. It won't give _nearly_ as good a debug report as a
"normal" oops, since I didn't want the double-fault handler to touch
anything even remotely unsafe, but it often gives a good hint about what
might be wrong. Certainly better than triple-faulting did (which we still
do for _catastrophic_ corruption, eg totally munged kernel page tables etc
- it's just very hard to avoid once you get corrupted enough).

		Linus


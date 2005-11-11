Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKKP1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKKP1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVKKP1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:27:32 -0500
Received: from ns1.suse.de ([195.135.220.2]:20660 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750810AbVKKP1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:27:31 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Date: Fri, 11 Nov 2005 16:27:13 +0100
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, prasanna@in.ibm.com,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <20051109165804.GA15481@elte.hu> <43723768.2060103@vmware.com>
In-Reply-To: <43723768.2060103@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111627.14403.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 18:52, Zachary Amsden wrote:

> Well, if there is a justification for it, that means we really should
> handle all the nasty EIP conversion cases due to segmentation and v8086
> mode in the kprobes code.  I was hoping that might not be the case.

Or just forbid kprobes for 16bit processes (or anything running in a non GDT
code segment). Would be perfectly reasonable IMHO.

-Andi

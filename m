Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTDYVyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTDYVyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:54:02 -0400
Received: from holomorphy.com ([66.224.33.161]:25525 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262406AbTDYVyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:54:02 -0400
Date: Fri, 25 Apr 2003 15:06:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <20030425220608.GT8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030425204012$4424@gated-at.bofh.it> <m3sms644zz.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3sms644zz.fsf@averell.firstfloor.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:
>> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
>> libraries directly above the program text? Red Hat seems to have patches to
>> dynamically tune it on a per-processes basis anyway ...

On Fri, Apr 25, 2003 at 11:54:56PM +0200, Andi Kleen wrote:
> Yes. You won't get a continuous sbrk/brk heap then anymore. Not sure it is a 
> big problem though.
> But apparently Solaris/x86 is doing that.
> It's probably worth a sysctl at least.

How about a personality? It is a very slightly different ABI.


-- wli

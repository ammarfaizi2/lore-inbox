Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTGVChj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 22:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTGVChi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 22:37:38 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:43497 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262464AbTGVChh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 22:37:37 -0400
To: =?iso-2022-jp-2?b?ShsuQRtOdnJuRW5nZWw=?= 
	<joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port SquashFS to 2.6
References: <fa.k0do8p6.ch6pps@ifi.uio.no> <fa.hre90bn.e6k5pf@ifi.uio.no>
From: junkio@cox.net
Date: Mon, 21 Jul 2003 19:52:39 -0700
In-Reply-To: <fa.hre90bn.e6k5pf@ifi.uio.no> (joern@wohnheim.fh-wedel.de's
 message of "Sun, 20 Jul 2003 08:25:16 GMT")
Message-ID: <7vd6g3uvbc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JE" == J.ANvrnEngel  <joern@wohnheim.fh-wedel.de> writes:

JE> On Sat, 19 July 2003 22:40:22 -0700, junkio@cox.net wrote:
>> - I would imagine that the acceptable stack usage for functions
>> would depend on where they are called and what they call.
>> Coulc you suggest a rule-of-thumb number for
>> address_space_operations.readpage (say, would 1kB be OK but
>> not 3kB?)

JE> Depending on where and what you do,...

Well, isn't asking about address_space_operations.readpage
specific enough?

JE> ... also depends a bit on the architecture.  s390 has
JE> giant stacks because function call overhead is huge, ...

The discussion was about putting variables (or arrays or large
structs) the kernel programmer defines on the stack, and I do
not think architecture calling convention has much to do with
this.

If an architecture has a big stack usage per call that is
imposed by the ABI, and larger kernel stack is allocated
compared to other architectures because of this reason,
shouldn't there be about the same amount of usable space left
for the kernel programs within the allocated per-process kernel
stack space to use?  If that is not the case then the port to
that particular architecture would not be optimal, wouldn't it?


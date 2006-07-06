Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWGFTmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWGFTmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWGFTmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:42:09 -0400
Received: from main.gmane.org ([80.91.229.2]:39352 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750768AbWGFTmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:42:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Thu, 06 Jul 2006 20:41:54 +0100
Message-ID: <yw1xejwy4j25.fsf@agrajag.inprovide.com>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca> <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:2MCP+PkaYhwUtrcaQpNXNhEjjCQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chris Friesen" <cfriesen@nortel.com> writes:

> Linus Torvalds wrote:
>
>> On Thu, 6 Jul 2006, Mark Lord wrote:
>
>>> A volatile declaration may be used to describe an object corresponding
>>> to a memory-mapped input/output port or an object accessed by an
>>> aysnchronously interrupting function.  Actions on objects so declared
>>> shall not be "optimized out" by an implementation or reordered except
>>> as permitted by the rules for evaluating expressions.
>> Note that the "reordered" is totally pointless.
>> The _hardware_ will re-order accesses. Which is the whole
>> point. "volatile" is basically never sufficient in itself.
>
> The "reordered" thing really only matters on SMP machines, no?

No, each CPU does write combining and write merging all on its own.

-- 
Måns Rullgård
mru@inprovide.com


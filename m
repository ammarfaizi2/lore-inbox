Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWH0UJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWH0UJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWH0UJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:09:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:7126 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751123AbWH0UJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:09:05 -0400
Date: Sun, 27 Aug 2006 22:03:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
In-Reply-To: <200608272019.15067.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0608272202200.21315@yvahk01.tjqt.qr>
References: <20060827084417.918992193@goop.org> <200608271757.18621.ak@suse.de>
 <44F1D464.5020304@goop.org> <200608272019.15067.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> +1:	movw GS(%esp), %gs
>> >
>> > movl is recommended in 32bit mode
>> 
>> arch/i386/kernel/entry.S: Assembler messages:
>> arch/i386/kernel/entry.S:334: Error: suffix or operands invalid for `mov'
>
>Looks like a gas bug to me.

So the suffixing (MOVW vs MOVL) does not depend on the source operand?
%gs is only 16 bit wide so MOVW seems reasonable. If the destination 
operand was a 32 bit location, something like MOVZX would be needed, would 
not it?

Jan Engelhardt
-- 

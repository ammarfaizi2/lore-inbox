Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWABT7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWABT7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWABT7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:59:24 -0500
Received: from khc.piap.pl ([195.187.100.11]:17156 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751000AbWABT7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:59:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <20051229224839.GA12247@elte.hu>
	<1135897092.2935.81.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	<20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
	<m3ek3qcvwt.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0601021105000.3668@g5.osdl.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 02 Jan 2006 20:59:21 +0100
In-Reply-To: <Pine.LNX.4.64.0601021105000.3668@g5.osdl.org> (Linus Torvalds's message of "Mon, 2 Jan 2006 11:12:21 -0800 (PST)")
Message-ID: <m3wthio0yu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> That's actually not a good practice. Two reasons:
>
>  - debuggability goes way down. Oops reports give a much nicer call-chain 
>    and better locality for uninlined code.

Right.

>  - Gcc can suck at big functions with lots of local variables. A 
>    function call can be _cheaper_ than trying to inline a function, 
>    regardless of whether it's called once or many times. I've seen 
>    functions that had several silly (and unnecessary) spills suddenly 
>    become quite readable when they were separate functions.

OTOH inlining helps much if both the caller and the called share the
same variables (values, calculated the same way from the same arguments).
-- 
Krzysztof Halasa

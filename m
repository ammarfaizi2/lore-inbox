Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTGBL7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 07:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTGBL7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 07:59:06 -0400
Received: from [66.212.224.118] ([66.212.224.118]:16138 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S264938AbTGBL7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 07:59:05 -0400
Date: Wed, 2 Jul 2003 08:02:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: To make a function get executed on cpu2
In-Reply-To: <E19XeSS-0008Rg-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.53.0307020758001.13565@montezuma.mastecende.com>
References: <E19XeSS-0008Rg-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Herbert Xu wrote:

> Surely you can emulate it using smp_call_function and make it return
> straight away if it runs on the wrong CPU.

Yes you can, i thought about the same thing, but it simply generates 
unecessary APIC bus traffic and just sounds horrid. Not to mention it 
doesn't sound all that friendly on larger systems. But if you're using 
smp_call_function you're not really all that speed critical anyway, so 
this should suffice.

	Zwane
-- 
function.linuxpower.ca

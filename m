Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbTIKRdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbTIKRbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:31:40 -0400
Received: from amdext2.amd.com ([163.181.251.1]:12512 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261440AbTIKRSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:18:42 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B19A@txexmtae.amd.com>
From: richard.brunner@amd.com
To: ak@suse.de, davej@redhat.com
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Thu, 11 Sep 2003 12:17:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 137E71C02325899-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Thursday, September 11, 2003 7:29 AM
> 
> On Thu, 11 Sep 2003 15:14:51 +0100
> Dave Jones <davej@redhat.com> wrote:
> 
> > On Thu, Sep 11, 2003 at 04:01:08PM +0200, Andi Kleen wrote:
> > 
> >  > > What's wrong with the current status quo that just says 
> >  > > "Athlon prefetch is broken"?
> >  > It doesn't fix user space for once.
> > 
> > And for another, it cripples the earlier athlons which 
> > don't have this
> > errata. Andi's fix at least makes prefetch work again on 
> > those boxes.
> > It's also arguable that prefetch() helps the older K7's 
> > more than the
> > affected ones.
> 
> All Athlons have this Errata. I can trigger it on an old
> 900Mhz pre XP Athlon too. You just have to use 3dnow prefetch
> instead of SSE prefetch.
> 
> BTW the older Athlons currently don't use prefetch because 
> the alternative
> patcher does not handle 3dnow style prefetch.
> 

Avoiding prefetch for all Athlons and earlier Opterons/Athlon64
even in the kernel can really tank performance. And as Andi says
it still doesn't solve user mode from hitting the errata.
 
] -Rich ...
] AMD Fellow


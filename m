Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136678AbREARuL>; Tue, 1 May 2001 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136679AbREARuB>; Tue, 1 May 2001 13:50:01 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:43024 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S136678AbREARtr>; Tue, 1 May 2001 13:49:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF8F30DD01.CDAFFB0E-ON85256A3F.005BE8E3@urscorp.com>
Date: Tue, 1 May 2001 13:41:53 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/01/2001 01:45:32 PM,
	Serialize complete at 05/01/2001 01:45:32 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would suggest the opposite approach instead: make the PPC just 
> support isa_readx/isa_writex instead.
>
> Much simpler, and doesn't need changes to (correct) driver sources.
>
> I bet that the patch will be smaller too. It's a simple case of
> - do the ioremap() _once_ at bootup, save the result in a static
>   variable somewhere.
> - implement the (one-liner) isa_readx/isa_writex functions.
>
> On many architectures you don't even need to do the ioremap, as it's
> always available (same as on x86).

That would be my preferred solution as well. The one-liners are easy, the 
ioremap may be more fun. Time to investigate the ppc code and docs. 

Unless one of the kindly ppc maintainers who knows far more about the arch 
than me would like to do it :)

Mike


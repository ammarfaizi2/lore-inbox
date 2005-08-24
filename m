Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVHXTdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVHXTdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbVHXTdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:33:05 -0400
Received: from mail1.kontent.de ([81.88.34.36]:42473 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751479AbVHXTdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:33:04 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 21:32:52 +0200
User-Agent: KMail/1.8
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com> <Pine.LNX.4.61.0508241347020.30497@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508241347020.30497@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242132.52730.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 24. August 2005 20:22 schrieb linux-os (Dick Johnson):
> > sorry but I'm not sure to understand you...Do you mean that the first write
> > into reg_a pointer will be completed before the second write because they're
> > separated by a (;) ?
> 
> Yes. The compiler must make sure that every effect of all previous
> code and all side-effects are complete at a "sequence-point". There
> are several sequence-points and the most obvious is a ";".

What the compiler may or may not generate is a little beside the point.
You have no guarantee that the CPU will execute these instructions in
the order given. If you need ordered writes use the appropriate barriers,
eg. wmb();
If this is PCI you also need to worry about the bridge caching. You
need to do dummy reads.

	Regards
		Oliver

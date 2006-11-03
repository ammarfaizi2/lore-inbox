Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753404AbWKCRyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbWKCRyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbWKCRyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:54:17 -0500
Received: from khc.piap.pl ([195.187.100.11]:24520 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1753407AbWKCRyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:54:16 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Phillip Susi <psusi@cfl.rr.com>, Jun Sun <jsun@junsun.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?
References: <20061102021547.GA1240@srv.junsun.net>
	<454A1D82.7040709@cfl.rr.com>
	<1162486642.14530.64.camel@laptopd505.fenrus.org>
	<454A4237.90106@cfl.rr.com>
	<1162498205.14530.83.camel@laptopd505.fenrus.org>
	<454A627C.1090104@cfl.rr.com>
	<1162505945.14530.98.camel@laptopd505.fenrus.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 03 Nov 2006 18:54:13 +0100
In-Reply-To: <1162505945.14530.98.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Thu, 02 Nov 2006 23:19:05 +0100")
Message-ID: <m364dwju0q.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> you're right in theory, but the kernel only has a few pools of memory
> available, but not at every bit boundary. there is a 32 bit pool
> (GFP_DMA32) on some, a 30-ish bit pool (GFP_KERNEL) on others, and a 24
> bit pool (GFP_DMA) with basically nothing inbetween.

Perhaps naive question, but... what's wrong with allocating memory
from the top (within given address mask[1], size-wise)? I think we
don't allocate more than 1 page with kmalloc anymore, do we?

[1] - some devices (a specific StrongARM only?) need non-continuous
masks due to a hardware bug(s).
-- 
Krzysztof Halasa

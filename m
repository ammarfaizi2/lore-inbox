Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVJSLBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVJSLBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVJSLBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:01:21 -0400
Received: from webmail.LF.net ([212.9.160.14]:19463 "EHLO webmail.LF.net")
	by vger.kernel.org with ESMTP id S964790AbVJSLBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:01:21 -0400
Message-ID: <1129719675.4356277bd26fd@webmail.LF.net>
Date: Wed, 19 Oct 2005 13:01:15 +0200
From: gfiala@s.netic.de
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
References: <200510182201.11241.gfiala@s.netic.de> <200510182302.59604.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20051018213721.236b2107.akpm@osdl.org> <200510190145.45911.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200510190145.45911.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 170.56.58.152
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Andrew James Wade <andrew.j.wade@gmail.com>:
> > For example, the person whose application does repeated linear reads of
> the
> > first 100MB of a 4G file will get very upset.
> 
> As will any dumb heuristic for that matter; we'd need precognition[1] to
> avoid
> all of them. But we can hopefully make the failure modes rarer and more
> predictable. I don't know how my proposal would fare, and as I do not have
> the code to test the matter I think I shall drop it.
> 
> [1] Which could, on occasion, be provided by hinting.

That is why i said it should be configurable by root via proc/sys/kernel 
interface - if the system is intended to primarily run a database, set it to a 
different heuristic than to "desktop/multimedia-workstation".

Much like the recent IO-scheduler additions (do they affect this behaviour?)

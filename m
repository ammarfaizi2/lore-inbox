Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUDHBNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 21:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUDHBNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 21:13:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:31673 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261322AbUDHBNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 21:13:07 -0400
Subject: Re: RFC: COW for hugepages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
In-Reply-To: <20040407143447.4d8f08af.ak@suse.de>
References: <20040407074239.GG18264@zax>
	 <20040407143447.4d8f08af.ak@suse.de>
Content-Type: text/plain
Message-Id: <1081386710.1401.86.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 11:11:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Implementing this for ppc64 only is just wrong. Before you do this 
> I would suggest to factor out the common code in the various hugetlbpage
> implementations and then implement it in common code.

Have you actually looked at it and how huge pages are implemented
on the various architectures ?

Honestly, I don't think we have any common abstraction on things
like hugepte's etc... actually, archs aren't even required to use
PTEs at all.

I don't see how we can make that code arch-neutral, at least not
without a major redesign of the whole large pages mecanism.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUHYXhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUHYXhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHYXhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:37:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:63941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266281AbUHYXff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:35:35 -0400
Date: Wed, 25 Aug 2004 16:35:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
In-Reply-To: <1093476204.2170.55.camel@gaston>
Message-ID: <Pine.LNX.4.58.0408251633580.17766@ppc970.osdl.org>
References: <412AD123.8050605@jp.fujitsu.com>  <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
  <1093417267.2170.47.camel@gaston>  <Pine.LNX.4.58.0408250015420.17766@ppc970.osdl.org>
 <1093476204.2170.55.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Benjamin Herrenschmidt wrote:
> 
> Yup, but then, the user have to take care that behind a single "error
> checking" entity (a bridge for example), all devices have such drivers
> that honor the bridge-level locking and not their own.

Yes. I suspect that this all matters in places where you have pretty 
strict hardware controls anyway, so it's likely not a big deal. 

> On ppc64, I think we always have 1 bridge = 1 slot though, makes things
> easier (well, provided we don't start to try playing with error coming
> from slots on the g5).

Yes, I'd assume that most high-end hardware (ie the kind that people have
who care about these things in the first place) wants to minimize the
number of shared error reporting bridges anyway.

		Linus

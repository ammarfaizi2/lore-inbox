Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUBREr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUBREr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:47:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:26029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263424AbUBREr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:47:27 -0500
Date: Tue, 17 Feb 2004 20:46:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Dave Jones <davej@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Santiago Leon <santil@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
In-Reply-To: <20040218042340.GW8858@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402172044321.2686@home.osdl.org>
References: <40329A24.5070209@us.ibm.com> <1077065118.1082.83.camel@gaston>
 <20040218040130.GC26304@redhat.com> <20040218042340.GW8858@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > That can't be right surely ? That would make them utterly useless afaics.
> > I've not seen this happen in practice either with the 2 x86 cpufreq drivers
> > I wrote that both use bitfields extensively.
> 
> It _is_ right and they are utterly useless.  Original rationale was, indeed,
> "describe the layout of hardware registers" but it had gone to hell may years
> ago.  Any assumptions regarding their allocation are non-portable.

Well, to be fair, most compilers still aim to make them useful. 

There's a difference between "the standard doesn't guarantee anything" and 
"the implementation makes no sense". 

(Sadly, a lot of compiler people do seem to look to standards more than
actual users for guides to do things, but at the same time I do believe
that gcc has useful semantics for bitfields and hardware accesses. You
just have to know what the implementation-specific rules are)

		Linus

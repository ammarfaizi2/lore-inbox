Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUBRFGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUBRFGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:06:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:43684 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264238AbUBRFGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:06:04 -0500
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Dave Jones <davej@redhat.com>,
       Santiago Leon <santil@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0402172044321.2686@home.osdl.org>
References: <40329A24.5070209@us.ibm.com> <1077065118.1082.83.camel@gaston>
	 <20040218040130.GC26304@redhat.com>
	 <20040218042340.GW8858@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0402172044321.2686@home.osdl.org>
Content-Type: text/plain
Message-Id: <1077080607.1078.109.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 16:03:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There's a difference between "the standard doesn't guarantee anything" and 
> "the implementation makes no sense". 
> 
> (Sadly, a lot of compiler people do seem to look to standards more than
> actual users for guides to do things, but at the same time I do believe
> that gcc has useful semantics for bitfields and hardware accesses. You
> just have to know what the implementation-specific rules are)

Well... I still think it's asking for trouble in the long term
to rely on them .... It's definitely broken for drivers of devices
that can be used on different archs (PCI cards for example) since
the layout of the bitfields is different at least with gcc between
big and little endian machines. But I've also been bitten by
alignement issues within the bitfield in the past (not with gcc
though) and other funny things like that...

So overall, I just recommend to get rid of them.


Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUBRFGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUBRFGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:06:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5610 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263771AbUBRFFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:05:03 -0500
Date: Wed, 18 Feb 2004 05:04:57 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Santiago Leon <santil@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
Message-ID: <20040218050457.GZ8858@parcelfarce.linux.theplanet.co.uk>
References: <40329A24.5070209@us.ibm.com> <1077065118.1082.83.camel@gaston> <20040218040130.GC26304@redhat.com> <20040218042340.GW8858@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402172044321.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402172044321.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 08:46:52PM -0800, Linus Torvalds wrote:
> > ago.  Any assumptions regarding their allocation are non-portable.
> 
> Well, to be fair, most compilers still aim to make them useful. 
> 
> There's a difference between "the standard doesn't guarantee anything" and 
> "the implementation makes no sense". 
> 
> (Sadly, a lot of compiler people do seem to look to standards more than
> actual users for guides to do things, but at the same time I do believe
> that gcc has useful semantics for bitfields and hardware accesses. You
> just have to know what the implementation-specific rules are)

True.  However, most of the bitfield uses I've seen would become much cleaner
from rewrite to explicit mask-and-shift stuff.

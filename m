Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWBWS2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWBWS2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWBWS2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:28:11 -0500
Received: from ns.suse.de ([195.135.220.2]:53900 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751181AbWBWS2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:28:08 -0500
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 19:13:54 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231820.50384.ak@suse.de> <1140716051.4952.4.camel@localhost.localdomain>
In-Reply-To: <1140716051.4952.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231913.54806.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 18:34, Alan Cox wrote:
> On Iau, 2006-02-23 at 18:20 +0100, Andi Kleen wrote:
> > BTW I have been also pondering some time to really trust e820 and not
> > forcibly reserve 640K-1MB on 64bit.  That code was inherited from i386,
> > but probably never made too much sense
> 
> Depends if you want your boot video stuff to work, and vga space, and
> also how the ISA hole is used, some chipsets seem to use the RAM that
> would be there remapped elsewhere as SMM ram.

e820 should report that.

I would hope that e820 is correct on modern systems.

Ok it would be a test - if it causes too much collational damage it could be undone.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUFAPfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUFAPfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUFAPfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:35:46 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56476 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265081AbUFAPfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:35:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.41541.94498.145167@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 17:35:33 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
In-Reply-To: <20040601150913.GU2093@holomorphy.com>
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>
	<c892nk$5pf$1@terminus.zytor.com>
	<16572.38987.239160.819836@alkaid.it.uu.se>
	<20040601150913.GU2093@holomorphy.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Tue, Jun 01, 2004 at 04:52:59PM +0200, Mikael Pettersson wrote:
 > > You're assuming pointers have uniform representation.
 > > C makes no such guarantees, and machines _have_ had
 > > different types of representations in the past.
 > > Some not-so-obsolete 64-bit machines in effect use fat
 > > representations for pointers to functions (descriptors),
 > > but they usually cheat and use pointers to the descriptors
 > > instead. However, a C implementation could legally
 > > represent a function pointer as a 128-bit value, while
 > > data pointers remain 64 bits.
 > 
 > IIRC for all types foo, sizeof(foo *) <= sizeof(void *), no?
 > If so, 128-bit function pointers implies >= 128-bit void pointers.

No, sizeof(foo*) <= sizeof(void*) only holds for data pointers.
The C standard is very explicit about not guaranteeing any
relationship between function pointers and void*. However,
a function pointer can be converted to a pointer to a different
function type and back again, without loss of information.

/Mikael

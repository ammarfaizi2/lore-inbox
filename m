Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUCXBly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 20:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUCXBly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 20:41:54 -0500
Received: from palrel10.hp.com ([156.153.255.245]:10925 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262952AbUCXBlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 20:41:52 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.59229.808025.231875@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 17:41:49 -0800
To: Ulrich Drepper <drepper@redhat.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <4060E24C.9000507@redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Mar 2004 17:20:12 -0800, Ulrich Drepper <drepper@redhat.com> said:

  Uli> David Mosberger wrote:
  >> I guess I never quiet understood why an entire program header is
  >> needed for this, but that's just me.

  Uli> First, the ELF bits are limited and very crowded on some archs.  There
  Uli> is no central assignment so conflicts will happen.

Fair enough, but I don't see why this should imply that platforms that
already do have support for no-exec data/stack should be forced into
using PT_GNU_STACK.  Just for uniformity's sake?  Or is there a real
benefit?

  Uli> And one single bit does not cut it.  If you'd take a look, the
  Uli> PT_GNU_STACK entry's permissions field specifies what permissions the
  Uli> stack must have, not the presence of the field.  So at least two bits
  Uli> are needed which only adds to the problems of finding appropriate bits.

What stack protections other than RW- and RWX are useful?

	--david

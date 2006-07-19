Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWGSAbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWGSAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWGSAbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:31:08 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:4756 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932432AbWGSAbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:31:07 -0400
Date: Tue, 18 Jul 2006 20:25:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: show_registers(): try harder to print
  failing code
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Andi Kleen" <ak@suse.de>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607182027_MC3-1-C55F-B4E8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <9a8748490607181512t11e9970eu1a7aa1ad1644ec54@mail.gmail.com>

On Wed, 19 Jul 2006 00:12:32 +0200, Jesper Juhl wrote:
> 
> > show_registers() tries to dump failing code starting 43 bytes
> > before the offending instruction, but this address can be bad,
> > for example in a device driver where the failing instruction is
> > less than 43 bytes from the start of the driver's code.  When that
> > happens, try to dump code starting at the failing instruction
> > instead of printing no code at all.
> >
> Shouldn't the kernel be printing some info noting that this fallback
> is in use then? Or will that be completely obvious and I'm just not
> able to see that?

The code byte at EIP is marked with '<>', so it's obvious:

Code: <a1> 00 00 00 00 c7 04 24 05 30 b5 de 89 44 24 04 e8 f5 6f 5c e1 c9 31 c0 c3 00 00 00 00 00 00 00

-- 
Chuck

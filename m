Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTJGKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 06:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTJGKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 06:04:09 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:11653 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id S261802AbTJGKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 06:04:07 -0400
Date: Tue, 7 Oct 2003 12:03:56 +0200
Message-Id: <200310071003.h97A3uQ11910@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: "Pascal Schmidt" <der.eremit@email.de>
To: "LarryMcVoy" <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> schrieb am 07.10.03 02:57:03:

> > So you're saying the LGPL and the GPL mean the same thing for
> > libraries?  That, for instance, you can handle Qt as if it was LGPL?
> I think so, I'm afraid.  I know that this view of the law isn't what
> people think is true and the end result may well be a court case which
> tests it.

Well, for libraries, the only thing that the GPL forbids and the LGPL
allows (at least in the eyes of the FSF, grain of salt and all that) is
statically linking with the library and then distributing the resulting
program under a non-GPL license.

Fits nicely with the boundary definition you gave, because linking
statically means that the result is one program and you cannot
take it apart without wrecking it.

I think that also applies to kernel modules. Dynamically loading them
works like linking with a library dynamically  (the lib in this case being
the kernel). But statically including code into a module is like
static linking. This happens when kernel headers declare non-trivial
static inline functions or macros, and that is problematic.

All the more reason for a seperate set of cleaned up linux-abi
header, isn't it?

-- 
Ciao,
Pascal



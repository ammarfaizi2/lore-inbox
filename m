Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWJJMYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWJJMYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWJJMYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:24:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965000AbWJJMYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:24:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>  <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org> <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr> <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Matthew Wilcox <matthew@wil.cx>,
       torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 10 Oct 2006 13:23:34 +0100
Message-ID: <5167.1160483014@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> Ouch ouch ouch. It should better be
>
> typedef uint32_t __u32;


Actually, if you want to guarantee the size of an integer variable with gcc,
you can do, for example, this:

	typedef int __attribute__((mode(SI))) siint;

which creates a 32-bit signed integer type called "siint".

The "mode" attribute is parameterised with one of the following values to
indicate the specific size of integer required:

	QI	8-bit
	HI	16-bit
	SI	32-bit
	DI	64-bit
	TI	128-bit

David

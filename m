Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbTI1Stx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTI1Stx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:49:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:28868 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262697AbTI1Stu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:49:50 -0400
Date: Sun, 28 Sep 2003 11:49:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: CONFIG_I8042
In-Reply-To: <20030928194511.C1428@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309281148350.15408-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Russell King wrote:
> 
> It appears that "select" doesn't accept conditionals as the kconfig
> language stands - jejb also ran into this issue, and tried various
> ways around.  The only solution which seems to work is to remove this
> select line entirely.

That is WRONG.

At least it should unconditionally select "SERIO", since the damn driver 
won't link without it.

The fact that it also requires a I8042 driver to actually _work_ on a PC
is a separate issue, but one that needs to also be resolved some way.

		Linus


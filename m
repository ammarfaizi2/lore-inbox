Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271686AbTHHQ0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271688AbTHHQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:26:42 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:17159 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271686AbTHHQ0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:26:41 -0400
Date: Fri, 8 Aug 2003 17:26:38 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Surprising Kconfig depends semantics
In-Reply-To: <Pine.LNX.4.44.0308081708390.714-100000@serv>
Message-ID: <Pine.LNX.4.44.0308081724140.12718-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > CONFIG_SERIO=m with CONFIG_KEYBOARD_ATKBD=y shouldn't be a valid 
> > combination.
> > 
> > The correct solution is most likely a
> > 	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> > 	default m if INPUT!=n && INPUT_KEYBOARD!=n && SERIO!=n
> 
> This is probably the easiest solution:
> 
> 	default INPUT_KEYBOARD && SERIO
> 
> (INPUT_KEYBOARD already depends on INPUT)

This is not the right solution. Not all input keyboard drivers use the 
serio layer. Take alook at amikbd.c in input/keyboard/



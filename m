Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271379AbTHHPNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271384AbTHHPNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:13:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30482 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271379AbTHHPNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:13:53 -0400
Date: Fri, 8 Aug 2003 17:13:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Surprising Kconfig depends semantics
In-Reply-To: <20030808144408.GX16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308081708390.714-100000@serv>
References: <20030808144408.GX16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> CONFIG_SERIO=m with CONFIG_KEYBOARD_ATKBD=y shouldn't be a valid 
> combination.
> 
> The correct solution is most likely a
> 	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> 	default m if INPUT!=n && INPUT_KEYBOARD!=n && SERIO!=n

This is probably the easiest solution:

	default INPUT_KEYBOARD && SERIO

(INPUT_KEYBOARD already depends on INPUT)

> The semantics that in
> 
> config FOO
> 	tristate
> 	default y if BAR
> 
> FOO will be set to y if BAR=m is a bit surprising.

Why?

bye, Roman


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272072AbTHHXbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272118AbTHHXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 19:31:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54532 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272072AbTHHXbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 19:31:19 -0400
Date: Sat, 9 Aug 2003 01:26:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: James Simmons <jsimmons@infradead.org>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Surprising Kconfig depends semantics
In-Reply-To: <Pine.LNX.4.44.0308082302130.32203-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0308090052330.714-100000@serv>
References: <Pine.LNX.4.44.0308082302130.32203-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, James Simmons wrote:

> > The easier solution is probably to force SERIO to 'y' as well, as the 
> > point of hiding it behind EMBEDDED is to get it compiled into the kernel.
> 
> What I mean is shouldn't build serio by default all the time. USB doesn't 
> need it as well as some other drivers like the Amiga keyboard driver.
> Serio can also be used by more things than I keyboard driver. Maybe I 
> misunderstood?

The problem is CONFIG_KEYBOARD_ATKBD and its dependency to CONFIG_SERIO, 
if CONFIG_KEYBOARD_ATKBD is forced into the kernel, so should 
CONFIG_SERIO.

bye, Roman


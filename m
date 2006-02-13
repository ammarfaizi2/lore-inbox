Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWBMMJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWBMMJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWBMMJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:09:55 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53726 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751761AbWBMMJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:09:54 -0500
Date: Mon, 13 Feb 2006 13:09:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213114612.GA30500@elte.hu>
Message-ID: <Pine.LNX.4.61.0602131306420.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> > That would would be a compiler problem, these const _are_ bogus.
> 
> code size is really important for the ktime ops, so i'd keep the consts 
> for the time being. In any case, it's definitely not a 2.6.16 change.

I checked with gcc-3.3 and before the patch:

$ size kernel/built-in.o
   text    data     bss     dec     hex filename
 197342   48061   44896  290299   46dfb kernel/built-in.o

After the patch:

$ size kernel/built-in.o
   text    data     bss     dec     hex filename
 197346   48061   44896  290303   46dff kernel/built-in.o

Impressive savings...

bye, Roman

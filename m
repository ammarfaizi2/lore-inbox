Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWHVKhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWHVKhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWHVKhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:37:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:18104 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932158AbWHVKhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:37:16 -0400
Date: Tue, 22 Aug 2006 12:37:13 +0200
From: Andi Kleen <ak@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-Id: <20060822123713.78a5bcaf.ak@suse.de>
In-Reply-To: <C1CE9D4F-FBE2-4C4B-BCE9-49DF817E790C@mac.com>
References: <20060821212154.GO11651@stusta.de>
	<20060821232444.9a347714.ak@suse.de>
	<20060821214636.GP11651@stusta.de>
	<20060822000903.441acb64.ak@suse.de>
	<20060821222412.GS11651@stusta.de>
	<20060822002728.c023bf85.ak@suse.de>
	<20060821225837.GT11651@stusta.de>
	<20060822011320.a3491337.ak@suse.de>
	<C1CE9D4F-FBE2-4C4B-BCE9-49DF817E790C@mac.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 23:37:31 -0400
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On Aug 21, 2006, at 19:13:20, Andi Kleen wrote:
> >> What's the problem with adding -ffreestanding and stating  
> >> explicitely which functions we want to be handled be builtins, and  
> >> which functions we don't want to be handled by builtins?
> >
> > Take a look at lib/string.c and think about it a bit.
> 
> So why can't lib/string.c explicitly say __builtin_foo() instead of  
> foo() where we mean the former? 

Because gcc when using builtins sometimes decides to call the 
out of line version (usually when it can't figure out the alignment
and generic alignment code would be too large to inline). And it will
always call str/memfoo not __builtin_str/memfoo

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTDWUYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDWUYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:24:41 -0400
Received: from pop.gmx.de ([213.165.65.60]:59182 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263620AbTDWUYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:24:40 -0400
Date: Wed, 23 Apr 2003 22:36:39 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423223639.7cc6a796.gigerstyle@gmx.ch>
In-Reply-To: <1051126871.1893.35.camel@laptop-linux>
References: <20030423135100.GA320@elf.ucw.cz>
	<Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
	<20030423144705.GA2823@elf.ucw.cz>
	<20030423175629.7cfc9087.gigerstyle@gmx.ch>
	<1051126871.1893.35.camel@laptop-linux>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel, Hi All

On Thu, 24 Apr 2003 07:41:11 +1200
Nigel Cunningham <ncunningham@clear.net.nz> wrote:

> Swsusp will use the portion of your swap partition that is unused when
> you start to suspend. The version currently in the 2.5 tree frees most
> of your memory before suspending, and so doesn't need that much swap at
> all. The version that I'm working on merging only frees memory if it is
> necessary to fit the image in the available swap or to have enough
> memory to be able to save the image. Thus, you need a lot more swap for
> my version. (eg. I have 640MB ram on my laptop and a ~700MB swap
> partition).
> 

Ok! I see the advantages / disadvantages of each version. But what happens if the memory AND swap space are full and nothing can't be freed? When I watch the memory and swap consumption on my laptop, I think it's the most time the case...

Another question:
Is it a big problem to save the memory in a separate file on the file system, and save somewhere the pointer to it (as example in swap. Also we could set a flag in swap so that we now that the last shutdown was a hybernation). One Problem will be, that we don't know the filesystem type on resume...(We could save the module in swap...)
All that is just theoretical. It's only a idea.

Thank you for your statements.

greets

Marc

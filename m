Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbTD0N5x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 09:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbTD0N5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 09:57:53 -0400
Received: from colin.muc.de ([193.149.48.1]:34832 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id S264663AbTD0N5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 09:57:53 -0400
Message-ID: <20030427160952.25210@colin.muc.de>
Date: Sun, 27 Apr 2003 16:09:52 +0200
From: Andi Kleen <ak@muc.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] An generic subarchitecture for 2.5.68
References: <20030427012238.GA13997@averell> <20030426231147.69efb07d.akpm@digeo.com> <20030427134217.GA1287@averell> <Pine.LNX.4.44.0304271555530.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.44.0304271555530.5042-100000@serv>; from Roman Zippel on Sun, Apr 27, 2003 at 03:58:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 03:58:23PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 27 Apr 2003, Andi Kleen wrote:
> 
> > Really BIGSMP, SUMMIT, GENERICARCH need to be only enabled with
> > SMP is enabled.
> > 
> > But Kconfig seems to ignore depends inside choice. Roman, any ideas
> > how to fix that?
> 
> What did you try? E.g. this works fine here:
> 
> config X86_BIGSMP
> 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
> 	depends on SMP
> 	help
> 	...

I made GENERICARCH depend on SMP and it was still defined after an 
make oldconfig

-Andi

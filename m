Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWABTyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWABTyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWABTyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:54:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16022 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750992AbWABTyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:54:12 -0500
Date: Mon, 2 Jan 2006 20:53:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Krzysztof Halasa <khc@pm.waw.pl>, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102195348.GA28691@elte.hu>
References: <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org> <20060102191720.GI22293@devserv.devel.redhat.com> <Pine.LNX.4.64.0601021130300.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601021130300.3668@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> And people are nervous about it, exactly because the gcc people have 
> historically just changed what "inline" means, with little regard for 
> real-life code that uses it. [...]

i think whatever gcc does, we probably cannot get hurt more than we are 
hurting right now: everything is inlined, which bloats stuff to the 
maximum level. Stating that doesnt in any way excuse gcc 3.1's 
unilateral change of what 'inline' means, it doesnt reduce the distrust 
that might exist towards gcc, it's simply a statement of the situation 
we have right now. We can continue to distrust gcc (and probably 
rightfully so), but we probably cannot continue to hurt users as 
collateral damage of whatever tool-level fight. (and i'm not suggesting 
that this collateral damage is intentional in any way, it slowly evolved 
into the mess we have now.)

	Ingo

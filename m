Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVAQQjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVAQQjC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVAQQjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:39:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:5047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262257AbVAQQi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:38:57 -0500
Date: Mon, 17 Jan 2005 08:38:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tigran Aivazian <tigran@veritas.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
Message-ID: <Pine.LNX.4.58.0501170836250.8178@ppc970.osdl.org>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
 <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
 <cs9v6f$3tj$1@terminus.zytor.com> <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jan 2005, Tigran Aivazian wrote:
> 
> So, this means there is no way for kdb on x86_64 to show the parameter 
> values for each function in the back trace. Any chance of changing the 
> ABI/x86_64 to do the right (i.e. passing via stack like on i386) thing 
> now? Then kdb would automatically support it via normal ar-handling code.

"right thing"? You have a very strange definition of "right". The x86 is 
pretty much the only architecture still in use that passes everything on 
the stack by default, and even there it's considered pretty painful (and 
is not true of FP arguments).

If a debugger cannot handle arguments in registers, it by definition 
cannot handle things like alpha/ppc/mips/xxx, so I'd say that the 
debugger is seriously broken.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUEAWQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUEAWQw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUEAWQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:16:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:52967 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262424AbUEAWPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:15:47 -0400
Date: Sat, 1 May 2004 15:14:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: marc@linuxant.com, mbligh@aracnet.com,
       tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-Id: <20040501151401.6d238243.rddunlap@osdl.org>
In-Reply-To: <20040501153319.6f9ece87.seanlkml@rogers.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
	<Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
	<90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
	<6900000.1083388078@[10.10.2.4]>
	<772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
	<20040501153319.6f9ece87.seanlkml@rogers.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 15:33:19 -0400 Sean Estabrooks <seanlkml@rogers.com> wrote:

| On Sat, 1 May 2004 15:12:18 -0400
| Marc Boucher <marc@linuxant.com> wrote:
| 
| > It was already screwed up, and causing unnecessary support burdens
| > both on the community ("help! what does tainted mean") and vendors.
| > This thread and previous ones have shown ample evidence of that.
| 
| Tainting is working just like it is supposed to work.   The reduced
| support burden for senior Linux maintainers has been a benefit.
| 
| > Let's deal with the root problem and fix the messages, as Rik van Riel
| > has suggested.
| 
| The kernel maintainers will decide what's best for Linux.   They're the
| ones responsible for overseeing Linux.    But if we're going to change
| the message i'd prefer something along the lines of:
| 
| "Now loading a non GPL driver.   Please consider supporting vendors that
| provide open source drivers for their hardware.  Your kernel will now be
| marked as tainted, all this means is that you should send any support
| requests to the author of this driver."

I agree, this is better than the Aunt Tillie message.
(Second sentence could be omitted.  I agree with it,
but it's not in the right setting IMO.)

[snip]

| > > What's wrong with the printk setting workaround? Simply write a number
| > > to the appropriate file before you load the modules.
| > >
| > > I just tried googling for the relevant post, but failed...
| > >
| > > He doesn't need to wait for the patches to propogate. He can act on
| > > his own scripts immediately in readiness for the next version.
| > >
| > > Easy.
| > 
| > Not. We don't use a script to systematically load the modules,
| > because they are large and not always required, nor want to
| > interfere with the system's normal logging.
| >
| > Manipulating printk settings or redirecting the superfluous
| > messages elsewhere are also ugly hacks, which can
| > potentially also divert/hide important messages.

So why is the tainted message to be different?

--
~Randy

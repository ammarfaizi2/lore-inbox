Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUE1Txr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUE1Txr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUE1Txr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:53:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:47773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263868AbUE1TxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:53:10 -0400
Date: Fri, 28 May 2004 12:42:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Proposal] DEBUG_SLAB should select DEBUG_SPINLOCK
Message-Id: <20040528124228.105ebcbb.rddunlap@osdl.org>
In-Reply-To: <528yfc72u8.fsf@topspin.com>
References: <528yfc72u8.fsf@topspin.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 2004 12:45:35 -0700 Roland Dreier wrote:

| I recently had a rather amusing debugging session.  I developed some
| code that worked fine on my test kernel, which had CONFIG_DEBUG_SLAB
| turned on.  However, as soon as I moved to a kernel without slab
| debugging to do some benchmarks, I started getting lockups.  It turns
| out that I had a spinlock in my data structure that I forgot to
| initialize but the poisoning from slab debugging had taken care of
| initializing it for me.  I didn't catch this during development
| because I had left CONFIG_DEBUG_SPINLOCK off.
| 
| Fortunately (for my sanity) I was able to diagnose this pretty quickly
| with the help of the NMI oopser.  However, for other developers' sake,
| I think it might make sense to add
| 
| 	select DEBUG_SPINLOCK
| 
| to the DEBUG_SLAB stanza of Kconfig.
| 
| I'm not posting a patch because I wanted to find out the status of
| Randy Dunlap's patch that consolidates the debugging options.  Is that
| patch going to be merged, in someone's tree somewhere, dropped, or what?

Andrew asked me to delay it until 2.6.6, which I did.
Sent that, but not merged.

I will be rediffing it and resending it again for 2.6.7 and
probably some intermediate kernels if that's what it takes.

| If the consensus is that we don't want to do this anyway, that's
| fine.  I mostly wanted to share this bug, which amused me.



--
~Randy

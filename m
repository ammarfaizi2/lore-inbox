Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTBLMmo>; Wed, 12 Feb 2003 07:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTBLMmo>; Wed, 12 Feb 2003 07:42:44 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:5306 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S267052AbTBLMmn>;
	Wed, 12 Feb 2003 07:42:43 -0500
Date: Wed, 12 Feb 2003 13:52:16 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030212125216.GA5259@k3.hellgate.ch>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com> <20030211154449.GA2252@k3.hellgate.ch> <1044985492.14143.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044985492.14143.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 17:44:53 +0000, Alan Cox wrote:
> I'd be happy to test via-rhine stuff, but my boxes don't generally like
> 2.5.x so I can only usefully test 2.4.x fixes

No prob. AFAIK the only significant difference 2.4/2.5 is the change you
made in 2.4.21pre4-ac1 (which, being short of IO-APIC hw, I can't test):

o       Always set interrupt line with VIA northbridge  (me)
        | Should fix apic mode problems with USB/audio/net on VIA boards

Besides that, Rhine drivers are in sync and should fail (or work)
identically in both trees.

However, unlike previous patches, changes pending now are not "obviously
right", so they need regression testing. 1.1.15exp1 for example cut the
time allowed for chip reset by three orders of magnitude [1]. Upcoming
patches will likely reshuffle code logic in order to fix races and bugs in
the current code.

So, thanks for the offer. If you can give 1.1.15exp1 a spin that'd be a
good start. It does fix a few existing problems and should not introduce
any new ones.

Roger

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=104050723916958&w=2

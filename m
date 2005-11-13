Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVKMD2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVKMD2e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVKMD2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:28:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:7387 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751247AbVKMD2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:28:34 -0500
Subject: Re: [2.6 patch] PPC_PREP: remove unneeded exports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Michael Buesch <mbuesch@freenet.de>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051113012608.GH21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <200511122237.17157.mbuesch@freenet.de> <20051112215304.GB21448@stusta.de>
	 <200511122257.05552.mbuesch@freenet.de> <20051112222045.GC21448@stusta.de>
	 <1131834667.7406.49.camel@gaston>  <20051113012608.GH21448@stusta.de>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 14:23:29 +1100
Message-Id: <1131852210.5504.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 02:26 +0100, Adrian Bunk wrote:
> On Sun, Nov 13, 2005 at 09:31:06AM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> > > any way.
> > > 
> > > _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.
> > 
> > Therse are old PREP stuffs
> >...
> 
> Is the patch below OK?

The ucXXX variables should probably go (or at least be unexported) but I
would keep the _prep_type export for now, unless we are certain no
driver and no out of tree stuff neither uses it (hrm... might well be
the case).

In any case, the proper fix is probably to move the EXPORT_SYMBOL() out
of ppc_ksyms, and have it next to the declaration of the variable.

Ben.



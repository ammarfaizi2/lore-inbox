Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVKLWhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVKLWhD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVKLWhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:37:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:16089 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964865AbVKLWhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:37:00 -0500
Subject: Re: Linuv 2.6.15-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Michael Buesch <mbuesch@freenet.de>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051112222045.GC21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <200511122237.17157.mbuesch@freenet.de> <20051112215304.GB21448@stusta.de>
	 <200511122257.05552.mbuesch@freenet.de>  <20051112222045.GC21448@stusta.de>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 09:31:06 +1100
Message-Id: <1131834667.7406.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> any way.
> 
> _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.

Therse are old PREP stuffs

> But prep_init points to the real problem:
> 
> CONFIG_PPC_PREP requires code from arch/ppc/platforms/, but this 
> directory is never visited.
> 
> What is the correct fix?
> Migrate the code from arch/ppc/platforms/ to arch/powerpc/platforms/ ?

Yes, PREP need to be migrated, but that includes adding some minimum
device-tree support for it among others. And few people still have PREP
machines, I'm not even sure we have access to one here in ozlabs... I
think for 2.6.15, we'd better just disable it in .config for
ARCH=powerpc.

Ben.



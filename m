Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTHSSxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTHSSvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:51:00 -0400
Received: from zero.aec.at ([193.170.194.10]:28933 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261274AbTHSStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:49:08 -0400
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Andi Kleen <ak@muc.de>
Date: Tue, 19 Aug 2003 20:48:47 +0200
In-Reply-To: <miMw.5yo.31@gated-at.bofh.it> (Lars Marowsky-Bree's message of
 "Tue, 19 Aug 2003 19:50:16 +0200")
Message-ID: <m365ktxz3k.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it>
	<mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> writes:

> Yes, both are "correct" in the sense that the RFC allows this
> interpretation. The _sensible_ interpretation for practical networking
> however is #2, and the only persons who seem to believe differently are
> those in charge of the Linux network code...

Just spend a minute to think about multihoming and failover
between multiple links on a host.

For that the Linux default makes a lot of sense - you get automatic
transparent failover between interfaces without any effort.

In my experience everybody who wants a different behaviour use some
more or less broken stateful L2/L3 switching hacks (like ipvs) or
having broken routing tables. While such hacks may be valid for some
uses they should not impact the default case.

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271030AbTG1UtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271036AbTG1Us4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:48:56 -0400
Received: from ppp-62-245-210-230.mnet-online.de ([62.245.210.230]:64161 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S271030AbTG1UqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:46:02 -0400
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Mon, 28 Jul 2003 22:45:57 +0200
In-Reply-To: <edJU.6nT.25@gated-at.bofh.it> (Carlos Velasco's message of
 "Mon, 28 Jul 2003 12:50:10 +0200")
Message-ID: <frodoid.frodo.87brve1it6.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <e2Yb.5CB.17@gated-at.bofh.it> <e43Y.6x0.17@gated-at.bofh.it>
	<e43Y.6x0.19@gated-at.bofh.it> <e43Y.6x0.21@gated-at.bofh.it>
	<e43Y.6x0.23@gated-at.bofh.it> <e43Y.6x0.25@gated-at.bofh.it>
	<e43Y.6x0.15@gated-at.bofh.it> <e4nd.6K9.5@gated-at.bofh.it>
	<e4ne.6K9.11@gated-at.bofh.it> <e4x3.6RV.23@gated-at.bofh.it>
	<e4Qe.7cR.3@gated-at.bofh.it> <e503.7kj.23@gated-at.bofh.it>
	<e5jh.7yW.5@gated-at.bofh.it> <edJU.6nT.25@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Carlos Velasco" <carlosev@newipnet.com> writes:

Hello Carlos,

>>I don't deny that it fixes your problem, that is not what
>>we're talking about.  We're talking about how one should
>>fix the problem, and I'm trying to show you why "hidden"
>>patch is not the answer to that.

> Yes, and I'm trying to tell you that it's not the only way to solve it,
> but it is the simpliest way to do it. As I'm sure most of linux users
> that have steped into this "behaviour" think about it.

I can only speak for me, but I think the same.

I'd also like to constate, that not only I see the hidden patch as the
better and easier way, I also think it should not only be in the
standard kernel but also enabled by default.

For the majority of all cases, why should I want the current standard
behaviour? If I have two network cards but each of them on different
segments, I only want the machine to respond to the IP address
attached to the network card on the corresponding segment. If I want
both network cards with different IP adresses on the same segment (for
whatever reason, maybe load balancing), I'll put them both on the same
segment.

There may be reasons why someone wants the current behaviour in
special cases, but I think those cases are so special that you should
need additional configuration tweaks to enable the kernel doing
so. *Not* the other way round.

Regards,
Julien

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269485AbUINWkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269485AbUINWkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUINWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:38:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:31195 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269485AbUINWgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:36:45 -0400
Date: Tue, 14 Sep 2004 15:32:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kconfig: selecting an undefined symbol
Message-Id: <20040914153215.7ad2dd66.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0409141444300.10355-100000@math.ut.ee>
References: <Pine.GSO.4.44.0409141444300.10355-100000@math.ut.ee>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 14:47:14 +0300 (EEST) Meelis Roos wrote:

| drivers/video/Kconfig:466:warning: 'select' used by config symbol 'FB_I810' refer to undefined symbol 'AGP'
| drivers/video/Kconfig:467:warning: 'select' used by config symbol 'FB_I810' refer to undefined symbol 'AGP_INTEL'
| 
| This comes from
| 
| config FB_I810
|         tristate "Intel 810/815 support (EXPERIMENTAL)"
|         depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
|         select AGP
|         select AGP_INTEL
|         select FB_MODE_HELPERS
| 
| it really depends on X86 but AGP and AGP_INTEL are still not selectable
| on sparc64.
| 
| Any good way to cure it?

What's your goal?  Even if "we" changed the SELECTs to be
DEPEND ONs, as you say, it depends on X86, so what does that have
to do with sparc64?

--
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVDETgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVDETgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVDEStv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:49:51 -0400
Received: from colino.net ([213.41.131.56]:60661 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261724AbVDESo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:44:59 -0400
Date: Tue, 5 Apr 2005 20:44:49 +0200
From: Colin Leroy <colin@colino.net>
To: linux-usb-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
Subject: USB glitches after suspend on ppc
Message-ID: <20050405204449.5ab0cdea@jack.colino.net>
X-Mailer: Sylpheed-Claws 1.9.6cvs23 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are known issues with USB after suspend/resume (D3 hot) on
powerpc. For example, plugging or unplugging devices during sleep
results in oopses at resume; and one time out of two, the USB ports are
unpowered on resume (because the registers think they are, and
linux doesn't repower them. but they're not).

Both of these issues have patches available, patches that can be found
there for example:

http://colino.net/ibookg4/usb-ohci-fixes.patch
http://colino.net/ibookg4/usb-ehci-power.patch

What kind of work on these is needed so that they get in?

Thanks,
-- 
Colin

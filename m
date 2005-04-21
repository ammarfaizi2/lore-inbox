Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVDUCSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVDUCSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDUCSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:18:37 -0400
Received: from colino.net ([213.41.131.56]:21493 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261174AbVDUCSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:18:17 -0400
Date: Thu, 21 Apr 2005 04:18:08 +0200
From: Colin Leroy <colin@colino.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: add an option to force r/w mount
Message-ID: <20050421041808.148bcedf@jack.colino.net>
In-Reply-To: <Pine.LNX.4.61.0504202227370.857@scrub.home>
References: <20050420220242.48cb1427@jack.colino.net>
	<Pine.LNX.4.61.0504202227370.857@scrub.home>
X-Mailer: Sylpheed-Claws 1.9.6cvs36 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2005 at 22h04, Roman Zippel wrote:

Hi, 

> > for some reason yet unknown, fsck.hfsplus doesn't correctly set the
> > HFSPLUS_VOL_UNMNT flag here.
> 
> If fsck doesn't mark it clean, there must be a reason

By the way, the reason is that this stupid utility opens the device
read-only (hence it can't fix nothing).

from hfsplusutils/libhfsp/src/fscheck.c:

    result = fscheck_volume_open(&vol, device, HFSP_MODE_RDONLY);

Seeing that it has been untouched since 2002, I guess it'll be hard to
get it fixed. Or maybe it's just me being idiot and I should use
another fsck ?

-- 
Colin

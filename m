Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWAZP3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWAZP3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWAZP3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:29:51 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:21196 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751002AbWAZP3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:29:50 -0500
Date: Fri, 27 Jan 2006 00:29:25 +0900 (JST)
Message-Id: <20060127.002925.25911749.anemo@mba.ocn.ne.jp>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, tbm@cyrius.com, t.sailer@alumni.ethz.ch,
       perex@suse.cz, ralf@linux-mips.org
Subject: Re: ALSA on MIPS platform
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <s5hek2wb05q.wl%tiwai@suse.de>
References: <20060125.235007.126576298.anemo@mba.ocn.ne.jp>
	<s5hek2wb05q.wl%tiwai@suse.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 Jan 2006 20:03:13 +0100, Takashi Iwai <tiwai@suse.de> said:

tiwai> The right fix is, IMO, to port dma_mmap_coherent() to all
tiwai> archs.  Currently, it's only on ARM.

Thanks.  Is this solve both issue #1 and #2 ?

The most part of issue #1 will vanish if NEED_RESERVE_PAGES was
defined, and currently only ARM define this.  ARM defines
NEED_RESERVE_PAGES because it has dma_mmap_coherent(), right?

---
Atsushi Nemoto

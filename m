Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbULAGi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbULAGi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULAGi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:38:26 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41166 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261299AbULAGiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:38:21 -0500
Subject: Re: 2.6.10-rc2-mm4 - unknown symbol snd_ac97_restore_status and
	snd_ac97_restore_iec958
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Berger <mikeb1@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41AD60B0.2010908@t-online.de>
References: <36kC0-3Zo-23@gated-at.bofh.it>  <41AD60B0.2010908@t-online.de>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 01:38:20 -0500
Message-Id: <1101883100.17559.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 07:12 +0100, Michael Berger wrote:
> Dear LKML
> 
> I get following warnings with Kernel 2.6.10-rc2-mm4:
> 
> WARNING: 
> /lib/modules/2.6.10-rc2-mm4/kernel/sound/pci/ac97/snd-ac97-codec.ko 
> needs unknown symbol snd_ac97_restore_status
> WARNING: 
> /lib/modules/2.6.10-rc2-mm4/kernel/sound/pci/ac97/snd-ac97-codec.ko 
> needs unknown symbol snd_ac97_restore_iec958

Known bug, fixed in ALSA CVS.  The problem was that those symbols were
not exported if CONFIG_ PM was undefined.

Lee


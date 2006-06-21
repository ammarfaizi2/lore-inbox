Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWFUOxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWFUOxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWFUOxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:53:15 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:40169 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932125AbWFUOxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:53:14 -0400
Date: Wed, 21 Jun 2006 23:54:18 +0900 (JST)
Message-Id: <20060621.235418.59032700.anemo@mba.ocn.ne.jp>
To: 7eggert@gmx.de
Cc: rpurdie@rpsys.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LED: add LED heartbeat trigger
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E1FskCC-000109-LV@be1.lrz>
References: <6pRqN-5QK-19@gated-at.bofh.it>
	<E1FskCC-000109-LV@be1.lrz>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 19:39:04 +0200, Bodo Eggert <7eggert@elstempel.de> wrote:
> > +       This allows LEDs to be controlled by a CPU load average.
> > +       The flash frequency is a hyperbolic function of the 5-minute
> > +       load average.
> > +       If unsure, say Y.
> 
> Wouldn't the 1-minute-load be better?

Actually, this driver (and preceeding CONFIG_HEARTBEAT codes) is using
1-minute load average, avenrun[0].  This inconsistency has been exist
so long time (since 2.4 kernel at least).  I'll fix the help text and
a comment in driver anyway.

---
Atsushi Nemoto

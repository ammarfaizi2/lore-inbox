Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSAIUBE>; Wed, 9 Jan 2002 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAIUAs>; Wed, 9 Jan 2002 15:00:48 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:6899 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S289003AbSAIUAO>;
	Wed, 9 Jan 2002 15:00:14 -0500
Date: Wed, 9 Jan 2002 12:00:08 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: IrDA patches on the way...
Message-ID: <20020109120008.A12039@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	You know the story : another set of IrDA patches are ready to
be incorporated in the Linux kernel. One one hand, minor cleanups of
the stack, one the other hand nasty bugs in IrLPT and IrLAN (that
could crash your kernel).
	Patches are mostly obvious and have been tested on 2.4.18-pre2
and 2.5.2-pre10 (because I still want to keep 2.4.X and 2.5.X in
sync). Some patches will apply to 2.5.X with harmless line
differences. The last patch, ir248_config-3.diff is only to sync 2.4.X
with 2.5.X (Marcelo missed one bit).
        Have fun...

        Jean


[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir247_irlan_dynalloc-2.diff :
---------------------------
	o [CRITICA] Don't pass the same skb to two different state machines
        <Following patch from Martin Diehl, modified by me>
	o [CRITICA] Don't flag netdev as NETIF_F_DYNALLOC, because not kmalloc

ir247_lpt_fix.diff :
------------------
	o [CRITICA] Provide a valid skb when calling irlmp_connect_response()
	o [FEATURE] Display something meaningfull in /proc/net/irda/ircomm

ir247_debug_warn.diff :
---------------------
	<Patch from Kai Germaschewski>
	o [FEATURE] Remove compiler warning when not using DEBUG

ir247_drv_region-2.diff :
-----------------------
	<Patch from Steven>
	o [CORRECT] Cleanup check_region()/request_region() in various drivers

ir248_config-3.diff :
-------------------
	<Already in 2.5.1, for 2.4.18 only>
	o [FEATURE] Remove useless and confusing config option

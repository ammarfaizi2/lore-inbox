Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSGZCNO>; Thu, 25 Jul 2002 22:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSGZCNN>; Thu, 25 Jul 2002 22:13:13 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:57758 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316693AbSGZCNN>; Thu, 25 Jul 2002 22:13:13 -0400
Date: Thu, 25 Jul 2002 21:16:26 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: axel@hh59.org
cc: linux-kernel@vger.kernel.org, <kkeil@suse.de>
Subject: Re: 2.5.28: depmod: *** Unresolved symbols in dss1_divert.o, isdnloop.o
In-Reply-To: <20020725234841.GA18222@neon.hh59.org>
Message-ID: <Pine.LNX.4.44.0207252114300.384-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002 axel@hh59.org wrote:

> just built 2.5.28 and here are unresolved symbols in the above modules..
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.28; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.28/kernel/drivers/isdn/divert/dss1_divert.o
> depmod:         cli
> depmod:         restore_flags
> depmod:         save_flags
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.28/kernel/drivers/isdn/isdnloop/isdnloop.o
> depmod:         cli
> depmod:         restore_flags
> depmod:         save_flags
> make: *** [_modinst_post] Error 1

Yup, that's a known problem (actually I'm wondering why you don't see more
of these). ISDN has been broken by the removal of the global IRQ lock, and
since it's not easy to fix, it'll take its time until it works again with
CONFIG_SMP set.

--kai



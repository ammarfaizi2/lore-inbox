Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTCEQaO>; Wed, 5 Mar 2003 11:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTCEQaO>; Wed, 5 Mar 2003 11:30:14 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:25230 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267385AbTCEQaN>; Wed, 5 Mar 2003 11:30:13 -0500
Date: Wed, 5 Mar 2003 10:40:40 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-Reply-To: <200303051624.h25GOqGi006862@locutus.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0303051039140.31461-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, chas williams wrote:

> shocking!  so how about this then:
> 
> atm-y   := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
> mpoa-y  := mpc.o mpoa_caches.o mpoa_proc.o
> 
> obj-$(CONFIG_ATM) += atm.o
> atm-$(CONFIG_PROC_FS) += proc.o
> atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
> atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
> obj-$(CONFIG_ATM_CLIP) += clip.o
> obj-$(CONFIG_ATM_LANE) += lec.o
> obj-$(CONFIG_ATM_MPOA) += mpoa.o
> obj-$(CONFIG_PPPOATM) += pppoatm.o

Better, but I still think you should group the statements which define 
what atm.o is composed of, i.e. move the atm-$... up, or the atm-y down ;)

It's up to you, though, of course.

--Kai



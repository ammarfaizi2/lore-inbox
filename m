Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbSLRX1J>; Wed, 18 Dec 2002 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbSLRX1I>; Wed, 18 Dec 2002 18:27:08 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:37880
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267495AbSLRXZm>; Wed, 18 Dec 2002 18:25:42 -0500
Message-ID: <3E0105CF.B107B4D0@eyal.emu.id.au>
Date: Thu, 19 Dec 2002 10:33:35 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-e1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre2
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Summary of changes from v2.4.21-pre1 to v2.4.21-pre2
> ============================================
> [trimmed]
> Rusty Russell <rusty@rustcorp.com.au>:
>   o duplicate header in drivers_ieee1394_sbp2.c

Don't know if this patch is the source of this problem, but...

Build fails for drivers/ieee1394/sbp2.c where these two functions
	sbp2_handle_physdma_write
	sbp2_handle_physdma_read
are declared with an extra last argument 'u16 flags' in sbp2.h
but are missing this argument in their body in sbp2.c.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

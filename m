Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTAFEPW>; Sun, 5 Jan 2003 23:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbTAFEPV>; Sun, 5 Jan 2003 23:15:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50699 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265987AbTAFEPU>; Sun, 5 Jan 2003 23:15:20 -0500
Date: Sun, 5 Jan 2003 20:18:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] Stop APM as module from oopsing
In-Reply-To: <20030104221527.8E5E67C99@ritz.dnsalias.org>
Message-ID: <Pine.LNX.4.44.0301052017210.3087-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Jan 2003, Daniel Ritz wrote:
>
> trivial fix to stop APM from oopsing when compiled as module.
> against 2.5.54bk1. please apply.

Hmm.. I think this is potentially a bug even for non-modular builds, since 
apm_driver_version() is called from the APM thread, and as such it might 
in theory (although probably not in practice) run after the init sequence 
even when compiled in.

Applied, with modified checkin comments.

		Linus


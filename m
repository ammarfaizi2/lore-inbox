Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265655AbUFIHGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUFIHGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 03:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbUFIHGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 03:06:51 -0400
Received: from gate.perex.cz ([82.113.61.162]:15556 "EHLO
	outgoing.perex-int.cz") by vger.kernel.org with ESMTP
	id S265655AbUFIHGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 03:06:50 -0400
Date: Wed, 9 Jun 2004 09:08:23 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [RFC][PATCH] ALSA: Remove subsystem-specific malloc (0/8)
In-Reply-To: <200406082124.i58LOrMm016152@melkki.cs.helsinki.fi>
Message-ID: <Pine.LNX.4.58.0406090905530.1767@pnote.perex-int.cz>
References: <200406082124.i58LOrMm016152@melkki.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, Pekka J Enberg wrote:

> This patch introduces a kcalloc() and replaces ALSA magic allocator
> snd_kcalloc() and snd_magic_kcalloc() with it.  I also fixed a memory
> leak in the arm sa11xx driver and added a BUG() in seq_oss_synth to
> catch failing allocations.
> 
> I kept the snd_magic_cast macro in place just in case someone wants to
> add a generic type checking facility in the kernel and convert the users
> to use it.

I suggest to Linus and Andrew to postpone applying of these patches into
mainstream. We'll integrate them (maybe in a slightly modified form - 
after discussion on the alsa-devel mailing list) to our ALSA tree at 
first. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269280AbTCBT0u>; Sun, 2 Mar 2003 14:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269281AbTCBT0u>; Sun, 2 Mar 2003 14:26:50 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:14603 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S269280AbTCBT0t>; Sun, 2 Mar 2003 14:26:49 -0500
To: Richard Henderson <rth@twiddle.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Modules broken on alpha ?
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 02 Mar 2003 20:36:50 +0100
Message-ID: <wrp1y1p8srx.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard, Rusty,

I've been trying to use modules on alpha without much success (at
least on the latest 2.5.63-bk). Any non-trivial module fails to load
with a relocation error :

little-time:~# lsmod
Module                  Size  Used by
little-time:~# modprobe crc32
little-time:~# lsmod
Module                  Size  Used by
crc32                   3456  0 
little-time:~# modprobe depca
module depca: Relocation overflow vs section 17
FATAL: Error inserting depca (/lib/modules/2.5.63-mod/kernel/drivers/net/depca.ko): Invalid module format
little-time:~# modprobe 3c509
module 3c509: Relocation overflow vs section 19
FATAL: Error inserting 3c509 (/lib/modules/2.5.63-mod/kernel/drivers/net/3c509.ko): Invalid module format
little-time:~# lsmod
Module                  Size  Used by
crc32                   3456  0 
little-time:~# 

I'm using module-init-tools from Debian sid (0.9.10-1).

Any idea ?

Thanks.

        M.
-- 
Places change, faces change. Life is so very strange.

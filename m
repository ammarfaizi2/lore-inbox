Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTEKBPR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 21:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTEKBPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 21:15:17 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:46581 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261819AbTEKBPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 21:15:16 -0400
Message-ID: <3EBDA717.18C95CA4@eyal.emu.id.au>
Date: Sun, 11 May 2003 11:27:51 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-rc1-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc2-ac1: unresolved
References: <200305101412.h4AEC3107645@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Linux 2.4.21rc2-ac1

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc2-ac1/kernel/drivers/sound/ac97_codec.o
depmod:         wolfson_init11
depmod:         wolfson_init05
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc2-ac1/kernel/fs/xfs/xfs.o
depmod:         find_trylock_page
depmod:         path_lookup

In ac97_codec.c the missing functions are expected to be static,
declared but missing. Looks like an incomplete merge. I just
comment out the offending lines as I do not have these devices.

My XFS config is:

CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

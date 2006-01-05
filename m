Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWAEUwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAEUwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAEUwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:52:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28427 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932186AbWAEUwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:52:03 -0500
Date: Thu, 5 Jan 2006 20:51:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Deepak Saxena <dsaxena@plexity.net>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix EISA/VLB/PCI network controllers alignment in menuconfig
Message-ID: <20060105205153.GB15968@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Deepak Saxena <dsaxena@plexity.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051227210628.0575f672.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227210628.0575f672.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 09:06:28PM +0100, Jean Delvare wrote:
> The CS89x0 Kconfig entry currently breaks the alignment of all
> "EISA, VLB, PCI and on board controllers" that follow it in menuconfig.
> This patch fixes it.
> 
> This bug was introduced in version 2.6.13-rc1. A first, different fix
> attempt was made by Deepak Saxena:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=712cb1ebb1653538527500165d8382ca48a7fca1
> 
> But it seems it was then overwritten by a subsequent (unsigned?) changeset
> from Russell King:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e399822da0f99f8486c33c47e7ae0d32151461e5

It shouldn't have been overwritten - it's probably the result of a
mis-merge.  I would appear that Deepak's change went in via one tree
and mine via my own tree.

As far as that change being unsigned, I don't see why the removal of
a previous addition would require a Sign-off.  We never signed-off
for undoing BK changesets so I'm merely following the established
modus operandi.

I have no view on your patch since I never use any of the config
tools apart from oldconfig.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

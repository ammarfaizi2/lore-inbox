Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbUK3T2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUK3T2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUK3T2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:28:38 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:7514 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262266AbUK3T12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:27:28 -0500
Date: Tue, 30 Nov 2004 20:27:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Config files that aren't mach_defconfig...
Message-ID: <20041130192744.GA8777@mars.ravnborg.org>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.co.uk>,
	linux-kernel@vger.kernel.org
References: <16811.41030.901140.963491@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16811.41030.901140.963491@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 09:18:46AM +1100, Peter Chubb wrote:
> 
> Hi Sam,
>    I've just finished porting Linux 2.6 to a new ARM board, that needs
> a custom initramfs list.  My approach was to set
> CONFIG_INITRAMFS_SOURCE to point to
> "$(srctree)/arch/arm/configs/pleb2_initramfs" in the appropriate
> defconfig for the board, as it's a default configuration item; but
> Russell asks if there isn't a better place for a per-board default initramfs
> script to live? 

We have arch/$arch/configs for this specific purpose to store baord specific
configuration. So mixing *_defconfig and _initramfs is a natural choice.
Nothing is gained by introducing another directory for this purpose.

	Sam

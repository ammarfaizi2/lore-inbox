Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbULaKtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbULaKtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbULaKtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:49:03 -0500
Received: from levante.wiggy.net ([195.85.225.139]:33435 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261626AbULaKtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:49:01 -0500
Date: Fri, 31 Dec 2004 11:48:59 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Kevin Fenzi <kevin@tummy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: scripts/package/mkspec
Message-ID: <20041231104859.GI24603@wiggy.net>
Mail-Followup-To: Kevin Fenzi <kevin@tummy.com>,
	linux-kernel@vger.kernel.org
References: <20041231033323.1CBB4CB130@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041231033323.1CBB4CB130@voldemort.scrye.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Kevin Fenzi wrote:
> So, after installing the kernel rpm it checks for /sbin/mkinitrd and
> makes an initrd file for the newly installed kernel rpm. It also
> checks for a /sbin/new-kernel-package command and runs it on the new
> kernel if it exists to add the new kernel/initrd to grub/lilo. 

Why not use the same system as the Debian package uses? That runs
everything in /etc/kernel/postinst.d/ after installing and everything
in /etc/kernel/prerm.d/ before removing a package.

That is much more flexible than hardcoding something like mkinitrd or
new-kernel-package: it works on all architectures and gives the
administratie full freedom to hook into things.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

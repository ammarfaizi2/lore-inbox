Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTDUMWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTDUMWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:22:03 -0400
Received: from verein.lst.de ([212.34.181.86]:43278 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263830AbTDUMWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:22:03 -0400
Date: Mon, 21 Apr 2003 14:34:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oleg Drokin <green@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: "[PATCH] devfs: switch over ubd to ->devfs_name" breaks ubd/sysfs
Message-ID: <20030421143402.A25996@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20030421155530.A7544@namesys.com> <20030421141845.A25822@lst.de> <20030421163039.A7965@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030421163039.A7965@namesys.com>; from green@namesys.com on Mon, Apr 21, 2003 at 04:30:39PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 04:30:39PM +0400, Oleg Drokin wrote:
> fake major is easy, it allows you to register ubd device on two majors.
> This is useful e.g. for installing distros inside of UML.
> Distro installers are tend to look for IDE disk on major 3, for example.
> Then if you boot with ubd=3, installer will find the disk ;)

Not that I would argue in favour of using devfs, but to make this fake
major stuff useful with devfs you'd have to use the devfs entries of
the faked devices.  So instead of the ubd_fake devfs names you'd
better add a string boot option that'll get set into ->devfs_name for
those.


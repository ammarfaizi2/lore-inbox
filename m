Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTDUM1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbTDUM1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:27:42 -0400
Received: from angband.namesys.com ([212.16.7.85]:32137 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S263834AbTDUM1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:27:41 -0400
Date: Mon, 21 Apr 2003 16:39:44 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: "[PATCH] devfs: switch over ubd to ->devfs_name" breaks ubd/sysfs
Message-ID: <20030421163944.A8947@namesys.com>
References: <20030421155530.A7544@namesys.com> <20030421141845.A25822@lst.de> <20030421163039.A7965@namesys.com> <20030421143402.A25996@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421143402.A25996@lst.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Apr 21, 2003 at 02:34:02PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 21, 2003 at 04:30:39PM +0400, Oleg Drokin wrote:
> > fake major is easy, it allows you to register ubd device on two majors.
> > This is useful e.g. for installing distros inside of UML.
> > Distro installers are tend to look for IDE disk on major 3, for example.
> > Then if you boot with ubd=3, installer will find the disk ;)
> Not that I would argue in favour of using devfs, but to make this fake
> major stuff useful with devfs you'd have to use the devfs entries of
> the faked devices.  So instead of the ubd_fake devfs names you'd

There is separate option for this. Though it should be fixed, it seems.

But mind you, installers I've seen do not use devfs.

> better add a string boot option that'll get set into ->devfs_name for
> those.

There is. It is called "fakeide" ;)

This one should be fixed it seems.

Bye,
    Oleg

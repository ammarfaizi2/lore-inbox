Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWFSJjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWFSJjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWFSJjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:39:55 -0400
Received: from iona.labri.fr ([147.210.8.143]:13490 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750977AbWFSJjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:39:54 -0400
Date: Mon, 19 Jun 2006 11:39:53 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060619093953.GI4253@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Marcel Holtmann <marcel@holtmann.org>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	linux-hotplug-devel@lists.sourceforge.net
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr> <20060618231204.GB2212@suse.de> <20060618233508.GH4744@bouh.residence.ens-lyon.fr> <20060619032259.GB4651@suse.de> <20060619082355.GE4253@implementation.labri.fr> <1150709431.4277.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1150709431.4277.4.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann, le Mon 19 Jun 2006 11:30:31 +0200, a écrit :
> > > Or just tell your users to make sure that they have the uinput driver
> > > loaded,
> > 
> > They can't, since without it they can't even type things.
> 
> if you install a program or a driver that needs uinput loaded, then you
> have a clean requirement. So simply add a "modprobe uinput" to its init
> script.
> 
> Look at the TUN/Tap driver which has the same problem. The boot up
> scripts of various daemons (for example OpenVPN etc.) are making sure
> that the driver is loaded.

And vtun's script in debian doesn't, so that I had to load it by hand.
Don't justify lack of support thanks to corrections that people had to
add ;)

The problem I'm raising is that with udev we seem to be heading to
asking every program to know which module it should load by hand before
being able to use a /dev entry. This looks odd to me (why not opening
the /dev entry itself shouldn't autoload the driver?).

Samuel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVAPQQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVAPQQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVAPQQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:16:24 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:56618 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262123AbVAPQQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:16:08 -0500
Date: Sun, 16 Jan 2005 17:16:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: changing local version requires full rebuild
Message-ID: <20050116161622.GC3090@mars.ravnborg.org>
Mail-Followup-To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
References: <20050116152242.GA4537@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116152242.GA4537@mellanox.co.il>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 05:22:42PM +0200, Michael S. Tsirkin wrote:
> Hi!
> Is it just me, or does changing the local version always require
> a full kernel rebuild?
> 
> If so, I'd like to fix it, since I like copying
> my kernel source with --preserve and changing the
> local version, then going back to the old version in case of
> a crash.
> Its important to change the local version to force 
> make install and make modules_install to put things in a separate
> directory.

Just tried it out here.
After cp -Ra only a limited part of the kernel rebuilds.
o oiu.c in ieee directory - because it dependson the shell script
o A number of drivers that include version.h
	- This should be changed so local version does not affect
	  the reast of version.h.
o Other stuff that is always build if kernel has changed

Do you use "echo -mylocalver > localversion" to change the local version?

	Sam

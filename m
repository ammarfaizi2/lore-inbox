Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUHHUnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUHHUnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHHUnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:43:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:54204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266281AbUHHUnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:43:03 -0400
Date: Sun, 8 Aug 2004 13:42:43 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic /dev security hole?
Message-ID: <20040808204242.GA9358@kroah.com>
References: <1091969260.5759.125.camel@cube> <20040808175834.59758fc0.Ballarin.Marc@gmx.de> <1091977471.5761.144.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091977471.5761.144.camel@cube>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 11:04:31AM -0400, Albert Cahalan wrote:
> Perhaps there are other ways to deal with the problem though.

Do what a number of distros do these days, make /dev a ramfs or tmpfs.
That way no hardlinks outside /dev will work:
	$ ln /dev/hda /tmp/foo
	ln: creating hard link `/tmp/foo' to `/dev/hda': Invalid cross-device link

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTLQIbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 03:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLQIbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 03:31:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:37794 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263832AbTLQIbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 03:31:08 -0500
Date: Wed, 17 Dec 2003 00:31:00 -0800
From: Greg KH <greg@kroah.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev-009: Allow build with empty EXTRAS
Message-ID: <20031217083100.GA2126@kroah.com>
References: <20031216220406.A23608@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216220406.A23608@mail.kroptech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 10:04:06PM -0500, Adam Kropelin wrote:
> Need to let the shell expand $EXTRAS so it can properly detect an empty
> list. Without this patch, the build fails whenever $EXTRAS is empty.

$ export EXTRAS=
$ make
$ set | grep EXTRA
EXTRAS=
$ 

I can't duplicate this problem at all.  Someone else once reported it on
the linux-hotplug-devel list, with much the same fix up patch, but later
said they couldn't reproduce it either.

What version of make are you using?

works for me :)

thanks,

greg k-h

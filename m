Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTKITvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKITvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:51:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:35997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262774AbTKITvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:51:14 -0500
Date: Sun, 9 Nov 2003 11:50:16 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing device information in REMOVE agent
Message-ID: <20031109195016.GA2154@kroah.com>
References: <200311081602.25978.arvidjaar@mail.ru> <20031108222529.GB7671@kroah.com> <200311091306.13580.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311091306.13580.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 01:06:13PM +0300, Andrey Borzenkov wrote:
> 
> I'd like to (try to) replace current synchronous media change checks in 
> supermount by mounting device on insert and releasing it on remove. For those 
> cases when it makes sense of course, USB sticks in the first place.
> 
> But users are free to use any names or links for their device names i.e. they 
> can do
> 
> ln -s sda /de/myflash
> mount /dev/myflash
> 
> and on remove it is rather hard to match this name against DEVPATH. But I can 
> save (major,minor) when mounting and use it to match mounted filesystem on 
> remove.

You might want to look into what devlabel does, as it sounds like it
does much the same thing of what you are wanting to do.

Good luck,

greg k-h

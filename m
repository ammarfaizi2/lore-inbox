Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVCIQyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVCIQyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCIQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:54:33 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:15483 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261775AbVCIQyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:54:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T2FYGL9rBqoVY2Wb8TTuiHyHyVzj0hgIud2Lax2QpLLPhiR4kCMIjKJ8kkOmYeLiatwARoVCU2O8HyvoB4HQzEQICR9rtbzBZ6v/Pq61Y2yYwQew4NPWJ4xDmwaFVyoiK+kijHUBhzRKAXratNpslFva2ZgNzjHQeZ+wcASxCew=
Message-ID: <9e4733910503090854e245740@mail.gmail.com>
Date: Wed, 9 Mar 2005 11:54:30 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: [announce 7/7] fbsplash - documentation
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050308223728.GA11065@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308021706.GH26249@spock.one.pl>
	 <200503080418.08804.arnd@arndb.de>
	 <20050308223728.GA11065@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 23:37:29 +0100, Michal Januszewski <spock@gentoo.org> wrote:
> On Tue, Mar 08, 2005 at 04:18:07AM +0100, Arnd Bergmann wrote:
> 
> > It should probably just use its own hotplug agent instead of calling
> > the helper directly.
> 
> I've just had a look at it, and it seems possible. From what I have seen
> in the firmware_class.c code, it would require:
>  - registering a class somewhere in the initializaton code
>  - every time a request from fbcon is generated:
>    - register the class device
>    - create a timer
>    - call kobject_hotplug() to send the event to userspace
>    - unregister the device

framebuffer already has a class registered. check out /sys/class/grpahics.

You should be able to just call request_firmware and have it download
your image whenever you need it. It doesn't have to be firmware,
request_firmware will download anything.

-- 
Jon Smirl
jonsmirl@gmail.com

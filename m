Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFSVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFSVXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVFSVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 17:23:42 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:61640 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261326AbVFSVXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 17:23:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t8Lh747T+5vO541jgWi5xuRiPhU6Cqv5IB1WKbyV5H6+V/bBHQgCGVZpRbBdAYuVL5fXoOqLkFKGUHnfbsKLfijB4S+TWNVY7Sbrd4h3rztlu20/DE86h0pOnIHWzQeFM32TR2oD2lNTmJES5XPuH2OLBh0E5MR6T3D7tMpl830=
Message-ID: <105c793f050619142339c2e762@mail.gmail.com>
Date: Sun, 19 Jun 2005 17:23:40 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.12 udev hangs at boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506191639.27970.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506191639.27970.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/05, Nick Warne <nick@linicks.net> wrote:
> As to the missing /dev/ entries - remember you are using udev now - they
> appear 'on the fly' as and when you plug something in - ensure you have set
> 'hotplug' to start.
I have set hotplug to start on Slackware 10 (chmod a+x
/etc/rc.d/rc.hotplug) and it seems to start fine. When running the
default udev (v0.26) it loads all that I need for my external hard
disk except for sd_mod. If I manually modprobed sd_mod, /dev/sda and
/dev/sda1 would be automatically created, which was nice. With the
latest version of udev (v0.58) it loads sd_mod when I plug in the
drive, but /dev/sd** are not created dynamically (they are there all
the time). Having them created dynamically is nifty, but not necessary
for me. It would be nice if it was a little more brainless (e.g. /dev
entries are created on the fly by default) since I don't know how to
turn on/off dynamic creation of /dev entries.

Also, starting hotplug on boot gives a (slight) delay on my system.
This might be normal, but I'm not sure.

I'm probably not understanding something correctly, but this is what I'm seeing.

Thanks.

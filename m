Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUGGTjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUGGTjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUGGTjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:39:15 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:36660 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S265359AbUGGTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:39:06 -0400
Date: Wed, 7 Jul 2004 21:47:03 +0200
From: Dub Spencer <pch+lkml@myzel.net>
To: Adam Popik <popik@moon.tuniv.szczecin.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stupied userspace programs or kernel bug ?
Message-ID: <20040707194703.GA22895@lazy.shacknet.nu>
References: <200407071515.10625.m.watts@eris.qinetiq.com> <Pine.LNX.4.44.0407071641430.24331-100000@moon.tuniv.szczecin.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407071641430.24331-100000@moon.tuniv.szczecin.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 04:54:01PM +0200, Adam Popik wrote:
> On Wed, 7 Jul 2004, Mark Watts wrote:
> That test was with 2 host network and no more hosts, routers
> and others...  linux#  shold have this address for virtual
> use only on that machine (loopback interface), netmask on
> all linuxboxes are same, onlny on lo was /32.  When I use
> /24 mask and router (routing was good until assinging ip
> address to loopback) network traffic is broken about 40 icmp
> requests (outside local net)...  Is linux bugs ?  on same
> test on FreeBSD and Solaris 9 no problems (loopback is and
> only loopback)

you may want to check the installed routes, it may well be a
system configuration issue: netstat -ran (-finet on bsd), and
look if the local 192... address doesnt get routed via lo.

dub

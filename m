Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUGRUPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUGRUPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUGRUPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:15:51 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:17802
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263769AbUGRUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:15:50 -0400
Subject: Re: [PATCH] inotify 0.5
From: John McCutchan <ttb@tentacle.dhs.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
In-Reply-To: <1090181465.5281.41.camel@nosferatu.lan>
References: <1090180167.5079.21.camel@vertex>
	 <1090180432.5281.37.camel@nosferatu.lan>  <1090180960.5399.0.camel@vertex>
	 <1090181465.5281.41.camel@nosferatu.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1090182131.9290.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Jul 2004 16:22:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-18 at 16:11, Martin Schlemmer wrote:
> 
> Right, but kde also works with fam, and I assume the gamin support
> will only be in 2.[78] gnome-vfs?  Also, it would be nice to test
> currently with fam enabled stuff, as I want to remember inotify
> do not have issues with locking mounts like dnotify have?  Or is
> it rather a fam-related issue ?

Gamin is a API/ABI stable replacement for FAM. Just dropping in gamin
instead of fam should just work with all current software. Inotify does
not have the umount blocking problem. In fact it lets FAM/Gamin no that
a particular directory has been unmounted and is no longer available.
This will let konquerer/nautilus provide more user friendly clues to
users. 

John

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVEKJVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEKJVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEKJVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 05:21:51 -0400
Received: from node1.80686-net.de ([194.54.168.119]:24772 "EHLO
	mx1.80686-net.de") by vger.kernel.org with ESMTP id S261191AbVEKJVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 05:21:49 -0400
From: Manuel Schneider <root@80686-net.de>
To: jensen galan <jrgalan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: did i trash my kernel?
Date: Wed, 11 May 2005 06:24:52 +0200
User-Agent: KMail/1.8
References: <20050511090209.76029.qmail@web40911.mail.yahoo.com>
In-Reply-To: <20050511090209.76029.qmail@web40911.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505110624.52772.root@80686-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> In /usr/src/linux-2.4.28-gentoo-r5, I edited the
> Makefile so that "EXTRAVERSION = -gentoo-r5-new", and
> recompiled my custom kernel with the following
> commands:
>
> make mrproper
> make menuconfig
> make dep
> make bzImage
> make modules
> make modules-install
> make install
This looks fine so far except that we don't know if the settings in 
the .config-file match your computers hardware and needs.

> Bringing eth0 up via DHCP... [!!]
> ERROR: Problem starting needed services.
> "netmount" was not started.
This is NOT a kernel error message.
This message is printed by the shellscript /etc/init.d/net.eth0 which is 
started by init.

Maybe there is no module for eth0 loaded? Log in as root and try 
dhcpcd eth0
What happens? What error message do you get? Fix that.

> So, did I trash my original kernel?  Was the method I
> used to compile a custom kernel incorrect?
As I said above - this is NOT a kernel error. Maybe there's a missing module, 
but the would depend on your kernel configuration or 
on /etc/modules.autoload.d/kernel-2.4 (load the right modules on startup).

If you have further questions concerning this error and / or gentoo linux look 
at the forums at forums.gentoo.org or contact me directly. Don't bother the 
LKML with this.

Greets,

Manuel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUGZAVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUGZAVH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUGZAVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:21:07 -0400
Received: from linares.terra.com.br ([200.154.55.228]:63403 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S264647AbUGZAUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:20:55 -0400
Subject: Re: Future devfs plans
From: "Rafael do N. Pereira" <gotrooted@pop.com.br>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200407261445.i6QEjAS04697@freya.yggdrasil.com>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com>
Content-Type: text/plain
Message-Id: <1090801303.19924.15.camel@osts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 21:21:43 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 11:45, Adam J. Richter wrote:
> 	Do not delete devfs.
> 
> 	devfs allows drivers to be loaded when user level programs
> need them,


I think it can asnwer your question:

Q: But wait, I really want udev to automatically load drivers when they
   are not present but the device node is opened.  It's the only reason I
   like using devfs.  Please make udev do this.
A: No.  udev is for managing /dev, not loading kernel drivers.

Q: Oh come on, pretty please.  It can't be that hard to do.
A: Such a functionality isn't needed on a properly configured system. All
   devices present on the system should generate hotplug events, loading
   the appropriate driver, and udev will notice and create the
   appropriate device node.  If you don't want to keep all drivers for your
   hardware in memory, then use something else to manage your modules
   (scripts, modules.conf, etc.)  This is not a task for udev.

It was taken from http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ


 Rafael.


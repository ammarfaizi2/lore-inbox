Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbUJZNci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUJZNci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUJZNch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:32:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:46303 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262267AbUJZNa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:30:58 -0400
Date: Tue, 26 Oct 2004 15:19:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is anyone using the load_ramdisk= option in the kernel still?
In-Reply-To: <clkheo$otl$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0410261516220.14487@jjulnx.backbone.dif.dk>
References: <clkheo$otl$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 hpa@zytor.com wrote:

> Date: Tue, 26 Oct 2004 03:48:40 +0000 (UTC)
> From: hpa@zytor.com
> To: linux-kernel@vger.kernel.org
> Subject: Is anyone using the load_ramdisk= option in the kernel still?
> 
> Hi all,
> 
> I've come to the conclusion that in order to stay backwards
> compatible while moving root-mounting stuff to userspace, in the
> initial patch everything in prepare_namespace() and south needs to be
> fully supported in userspace.  This looks perfectly doable, but is a
> fair bit of work.
> 
> The one piece of ugliness I've encountered has to do with the
> load_ramdisk= option; this causes a ramdisk to be loaded from an
> external device, usually a floppy.  The ugliness has to do with the
> fact that it requires the kernel itself to deduce the size of the
> ramdisk, which is filesystem-specific.  Although this code is
> currently run for initrds as well, it doesn't need to, since the
> kernel knows the size of an initrd.
> 
> This code isn't complex by any means, but it's ugly and complex, and
> I'm trying to make something a bit cleaner than just copying the
> existing in-kernel code to userspace.
> 
> So, in short:
> 
> a) Does anyone use the load_ramdisk= option anymore, or is it
> legitimate to drop?
> 
I know Slackware Linux uses load_ramdisk= when you use floppies to start 
the install in the situations where booting from CD for some reason 
doesn't work. Slackware uses one boot disk and then 2 root disks in this 
case.


--
Jesper Juhl


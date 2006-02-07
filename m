Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWBGEmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWBGEmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWBGEmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:42:15 -0500
Received: from science.horizon.com ([192.35.100.1]:54073 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964975AbWBGEmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:42:15 -0500
Date: 6 Feb 2006 23:42:04 -0500
Message-ID: <20060207044204.8908.qmail@science.horizon.com>
From: linux@horizon.com
To: davidchow@shaolinmicro.com
Subject: Re: Linux drivers management
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any work in Linux undergoing to separate Linux drivers and the 
> the main kernel, and manage drivers using a package management system 
> that only manages kernel drivers and modules? If this can be done, the 
> kernel maintenance can be simple, and will end-up with a more stable 
> (less frequent changed) kernel API for drivers, also make every 
> developers of drivers happy.

Not very seriously.  Kernel developers really like the ability to change
every user of a kernel programming interface within a single source tree.
Breaking it up would make it harder to change the device driver interface
when necessary.  (It's already hard enough; nobody does it for fun.)

Also, a hardware manufacturer looking for a "stable API" is often
really looking for a stable *binary* interface because they want to
ship binary-only drivers.

The Linux developers are quite opposed to that, for a variety of excellent
reasons I won't bother enumerating.  Linus has said he'll (grudgingly)
allow it, but won't lift a finger to help.  Linux development sailed
away from the idea of a stable binary interface years ago, and isn't
looking back.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935467AbWKZSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935467AbWKZSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 13:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935476AbWKZSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 13:07:57 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:58602 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S935467AbWKZSH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 13:07:56 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64| perhaps
	duplicate bug report?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20061122152559.72efd379.akpm@osdl.org>
References: <1164205742.13434.4.camel@localhost>
	 <20061122152559.72efd379.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Nov 2006 19:07:49 +0100
Message-Id: <1164564469.9291.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-22 at 15:25 -0800, Andrew Morton wrote:
> On Wed, 22 Nov 2006 15:29:02 +0100
> Kasper Sandberg <lkml@metanurb.dk> wrote:
> 
> > it appears some sort of bug has gotten into .19, in regards to x86
> > emulation on x86_64.
> > 
> > i have only tested with >=rc5, thw folling, as an example, appears in
> > dmesg:
> > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > arg(00221000) on /home/redeeman
> > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
> 
> Try
> 
> 	echo 0 > /proc/sys/kernel/compat-log
> 
> I don't _think_ we did anything to change the logging in there.  Which kernel
> version were you using previously (the one which didn't do this)?
> 

it just struck me, that this may be the same bug Jesper Juhl has
discovered (atleast the hardlock part), as i read that thread, it strike
me that whenever i have hardlocks from this, its when i in wine runs
stuff that uses basically all my ram, and MAY even touch my swap.

just an idea.

> 


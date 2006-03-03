Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWCCNfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCCNfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCCNfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:35:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:46733 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751434AbWCCNfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:35:44 -0500
Date: Fri, 3 Mar 2006 14:35:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexander Mieland <dma147@linux-stats.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: how to find out which module was built by which .config variables?
In-Reply-To: <200603031420.46801.dma147@linux-stats.org>
Message-ID: <Pine.LNX.4.61.0603031434520.2581@yvahk01.tjqt.qr>
References: <200603031420.46801.dma147@linux-stats.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>I need to create a database with configuration options (the ones 
>in .config) and the resulting kernel modules.
>
Let's pick 8139too.ko for example.
Find /usr/src/linux -name 8139too.ko
In that same directory, look at the Makefile:
obj-$(CONFIG_8139TOO) += 8139too.o

>Is there any simple possibility (with bash and its applications) to find 
>out, which kernel modules will be built by which .config options? I know 
>that there are also many dependencies between the options and the modules 
>and I want to add them to the database too. The dependencies can be found 
>out with the Kconfig files, I think.
>
>I've already looked into the source files of some modules, but I can not 
>find any commonalities which would make it easy to find the module-name 
>which will be build.
>
>I've found some stuff like this:
>#define DRIVER_NAME	"8139too"
>or things linke:
>#define <something>_MODULES_NAME	"some string which seems to be the 
>descriptive name"
>
>But this doesn't really help... :(
>
>Sincerely
>
>Alexander Mieland
>
>-- 
>Alexander 'dma147' Mieland                   2.6.15-ck3-r1-fb-my4 SMP
>FnuPG-ID: 27491179                      Registered Linux-User #249600
>http://blog.linux-stats.org                http://www.linux-stats.org
>http://www.mieland-programming.de          http://www.php-programs.de
>

Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator

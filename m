Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUGDKJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUGDKJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUGDKJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:09:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:25065 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265490AbUGDKJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:09:06 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Init single and Serial console : How to ?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200407040509.i6459iX21158@tag.witbe.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bh3vk-0008Hb-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 04 Jul 2004 12:09:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200407040509.i6459iX21158@tag.witbe.net> you wrote:
>    ioctlsave is a small utility to create the Linux SysV init file
>    /etc/ioctl.save from a multiple user run level rather than from single
>    user mode. /etc/ioctl.save contains the terminal settings to be used in
>    single user mode.

this is only about terminal settings like flags  and line speed, it is not
related to presenting the login on the serial console. It is a good idea to
remove this file and set the baud rate on the boot command line.

You must configure /sbin/sulogin which is called from init to run on
/dev/console, then you will be fine. Also you should start a getty on
/dev/ttySx for multi user modes (see the serial console howto)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/

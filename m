Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTLELnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTLELnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:43:00 -0500
Received: from f19.mail.ru ([194.67.57.49]:28945 "EHLO f19.mail.ru")
	by vger.kernel.org with ESMTP id S263857AbTLELm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:42:59 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=watermodem=?koi8-r?Q?=22=20?= 
	<aquamodem@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs_mk_cdev  question
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Fri, 05 Dec 2003 14:42:57 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1ASEML-000P1A-00.arvidjaar-mail-ru@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am a litte perplexed.  Is this error message important?

> I am running linux-2.6.0-test11 on a modified Mandrake 9.2 rc2 release.

You may have any issues here, esp. with initscripts. You may try
current cooker.

> The sound card is playing as I type but on boot I saw:
> [
> Dec  4 16:44:27 dali kernel: Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 20 03 UTC).
> Dec  4 16:44:27 dali kernel: request_module: failed /sbin/modprobe -- snd-card-0. error = -16

EBUSY but no idea why it is reported; probably by driver?

> As I slowly work my way through the problems I see this:
> [
> Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent for snd/hwC0D0

check that /dev/snd is not a file or link or whatever. Remove it,
remove /lib/dev-state/snd and try again. If it persists (i.e. you
have non-directory /dev/snd appearing every time on boot) try
to find out why it is created. ALSA initscript in Mandrake creates
/dev/snd as link to /proc/whatever if it believes devfs is not present. It may be one possible reason.

-andrey


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUL1VV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUL1VV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUL1VV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:21:58 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2727 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261259AbUL1VV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:21:56 -0500
Subject: local root exploit confirmed in 2.6.10: Linux 2.6 Kernel
	Capability LSM Module Local Privilege Elevation
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 16:21:55 -0500
Message-Id: <1104268915.20714.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Barknecht pointed this out on linux-audio-dev, it's a horrible
bug, I confirmed it in 2.6.10, and have not seen it mentioned on the
list.

Executive summary:

run "vim" as normal user.  Do ":r /etc/shadow".  Permission denied.

do "modprobe capability" as root in another terminal

Do ":r /etc/shadow" again in the same vim.  You will be able to read and
write /etc/shadow as normal user.

http://www.derkeiler.com/Mailing-Lists/securityfocus/bugtraq/2004-12/0390.html

Lee


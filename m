Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbVKRVmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbVKRVmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKRVmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:42:33 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:10645 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932197AbVKRVmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:42:32 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 2.6.15-rc1-mm2 breaks strace
Date: Fri, 18 Nov 2005 22:40:33 +0100
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511182240.34512.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15-rc1-mm2 works nicely here, aside from the artsd stuff someone else 
already reported, and an new issue with strace (last known working: 
2.6.14-mm2)

[bero@localhost bero]$ strace ls
execve("/bin/ls", ["ls"], [/* 33 vars */]) = 0
Segmentation fault
[ls output without any traces beyond execve-ing ls displayed here]

Also interesting:
[bero@localhost bero]$ strace strace ls
execve("/usr/bin/strace", ["strace", "ls"], [/* 20 vars */]) = 0
Segmentation fault
execve("/bin/ls", ["ls"], [/* 20 vars */]) = 0
[ls output without any traces displayed here]

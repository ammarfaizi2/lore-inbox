Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265088AbUD3Hao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265088AbUD3Hao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUD3Hao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 03:30:44 -0400
Received: from main.gmane.org ([80.91.224.249]:1764 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265088AbUD3Ham (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 03:30:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Schulz <joe@spamfilter.de>
Subject: Problem spawning init from script
Followup-To: poster
Date: Fri, 30 Apr 2004 09:21:39 +0200
Message-ID: <c6suq3$ko7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd955bb31.dip.t-dialin.net
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello world,


for internal reasons I designed a custom boot procedure with two root
partitions. One is booted by default and a script is executed via the
"init=/sbin/initscript" kernel option.

The script restrieves some information and depending on that information
it decides whether the current boot should continue or some other
partition is being mounted and boot continues on that.

As the script involves the usage of USB storage, gpg, openssl, device
mapper and various other bits, it would make some pretty big and hard
to handle initrd so I decided to try it directly as described.

Infortunately when the script tries to exec'ute either one init proces or
the other at its end, the kernel always panics:

Kernel panic: Attempted to kill init!

Does that mean I MUST use initrd to be able to use such a script or is
there a way to get around this?

Hints appreciated,
                  Joe


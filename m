Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUFVCon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUFVCon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 22:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266540AbUFVCon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 22:44:43 -0400
Received: from outbound05.telus.net ([199.185.220.224]:12432 "EHLO
	priv-edtnes40.telusplanet.net") by vger.kernel.org with ESMTP
	id S266539AbUFVCom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 22:44:42 -0400
Subject: Re: [2.6.7-bk] NFS-related kernel panic
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087872607.4066.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Jun 2004 20:50:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  I get (a very similar) error with 2.6.7-bk4.
The error message I get is:
Starting portmapper:                            [OK]
Starting NFS statd: Kernel panic: Aiee, killing interrupt handler!
bad: scheduling while atomic!
 [<c02a2c37>] schedule+0x483/0x488
 [<c0133298>] __get_free_pages+0x33/0x3f
 [<c026974c>] tcp_poll+0x34/0x15a
 [<c02a30b5>] schedule_timeout+0xb5/0xb7
 [<c0248fb3>] sock_poll+0x29/0x31
 [<c015da2e>] do_pollfd+0x4f/0x90
 [<c015db10>] do_poll+0xa1/0xc0
 [<c016dc7e>] sys_poll+0x14f/0x211
 [<c015d09d>] __pollwait+0x0/0xc6
 [<c014afd2>] sys_close+0x63/0x96
 [<c0103eb1>] sysenter_past_esp+0x52/0x71
In interrupt handler - not syncing

And that's where it dies.
I don't have NFS as part of the build either. My build script shows the
following:
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set

Something is borken.

Bob


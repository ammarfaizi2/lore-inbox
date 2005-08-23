Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVHWI5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVHWI5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 04:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVHWI5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 04:57:14 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:38121 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932081AbVHWI5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 04:57:14 -0400
From: Grant.Coady@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm2
Date: Tue, 23 Aug 2005 18:57:04 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <nnolg1tusrn3q5p8qeorks8vhc3cromj8l@4ax.com>
References: <20050822213021.1beda4d5.akpm@osdl.org>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2005 21:30:21 -0700, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/
>
>- Various updates.  Nothing terribly noteworthy.

adm9240 i2c still broken, spamming debug with:
Aug 23 18:48:40 peetoo kernel: [ 1591.151460] i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.151834] i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.170515] i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.170881] i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.189837] i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.190217] i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.208927] i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
Aug 23 18:48:40 peetoo kernel: [ 1591.209296] i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00

As soon as write sysfs.  Dunno where to start, this is from adm9240 
driver that works in 2.6.13-rc6-git12 but not -mm1 or -mm2, terminal 
lost, but able to log in on another terminal.  -mm2 was okay until I 
wrote to sysfs.  With -mm1 it failed on reading the sysfs area as well, 
so there's a little progress.  

top:
top - 18:52:07 up 29 min,  2 users,  load average: 0.99, 0.62, 0.26
Tasks:  50 total,   3 running,  47 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.3% us,  0.0% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    515360k total,   146504k used,   368856k free,    15932k buffers
Swap:   514000k total,        0k used,   514000k free,   109296k cached

Grant.


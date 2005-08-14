Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVHNTzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVHNTzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVHNTzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 15:55:49 -0400
Received: from mail.linicks.net ([217.204.244.146]:51461 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932141AbVHNTzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 15:55:48 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Date: Sun, 14 Aug 2005 20:55:35 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508142055.35731.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:

> 
> The "hdparm -I /dev/hdc"
> 
> hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdc: drive_cmd: error=0x04 { AbortedCommand }
> de: failed opcode was: 0xec
> 
> Is present on all kernels that I have locally (oldest 2.6.11.11)
> so it is not related to the threadstarters problems, it seems.

Hi all,

Maybe teaching you all to suck eggs here, but I used to get this a lot on my 
CD's - KDE ran some probe and as the CD[s] where empty logs filled up rapidly 
with that error.  I thought the[a] drive was duff, so bought a new CD-RW.

Made no difference :-/  I then investigated further, and read that instead of 
the SCSI emulation, it was superceded by IDE-CD.

kernel 2.6.12.3

Kernel command line: BOOT_IMAGE=Nicks ro root=303 hdc=ide-cd hdd=ide-cd

Fixed the issue for me.  But as I say, teaching to suck eggs, but I thought I 
would mention it.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

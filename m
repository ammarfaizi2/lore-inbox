Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbSKCWsC>; Sun, 3 Nov 2002 17:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSKCWrf>; Sun, 3 Nov 2002 17:47:35 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:25608 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263203AbSKCWr0>; Sun, 3 Nov 2002 17:47:26 -0500
Date: Sun, 3 Nov 2002 23:53:58 +0100 (CET)
Message-Id: <200211032253.gA3Mrw1B008818@smtpzilla1.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
Reply-To: hanwen@cs.uu.nl
To: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [Help!] 2.4.20 IDE-SCSI / CD-writing crash
In-Reply-To: <3DC59E5B.2040007@yahoo.com>
References: <3DC59E5B.2040007@yahoo.com>
X-Mailer: VM 7.05 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rankincj@yahoo.com writes:
> I ain't no Linux kernel genius, but I did see this patch on the 
> linux-kernel mailing list. Also rubber-stamp approved by Alan Cox. Do 
> you think it might help you?

> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0211.0/0278.html

1st try (running as root from commandline): success
2nd try  (running as user, cdrecord invoked from gtoaster):

  SCSI host 0 abort ..  timed out - resetting
  aborting command due to timeout .. test unit ready .. 00 00 00 00 00 
  aborting command due to timeout .. prevent/allow medium removal 00
  00 00 01 00

after a reboot, I get the same problems (1st try success, 2nd try
fail, now with with messages from the IDE layer about DMA and "DRQ not
asserted yet"). Interesting observations: that I forgot to mention the
first e-mail:

* it seems to go wrong happen mostly the 2nd try, I can't recall
  failing on the first try after bootup,

* when the kernel goes into this reset loop, everything is hanging,
  e.g. when pressing num-lock from console it takes a few seconds
  before the indicator led changes


-- 

Han-Wen Nienhuys   |   hanwen@cs.uu.nl   |   http://www.cs.uu.nl/~hanwen 

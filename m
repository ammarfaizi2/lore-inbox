Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTEUXuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTEUXuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:50:44 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:36026 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262367AbTEUXun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:50:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Date: Thu, 22 May 2003 01:59:08 +0200
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305220159.08452.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a list of things we need to do on s390 for 2.6:

arch/s390/
~~~~~~~~~

o A nastly memory management problem causes random crashes.
  These appear to be fixed/hidden by the objrmap patch, more
  investigation is needed.

drivers/s390/
~~~~~~~~~~~~~

o Early userspace and 64 bit dev_t will allow the removal of most of
  dasd_devmap.c and dasd_genhd.c.

o The 3270 console driver needs to be replaced with a working one
  (prototype is there, needs to be finished).

o Minor interface changes are pending in cio/ when the z990 machines
  are out.

There are some more things being worked on that are either post-2.6.0
or are likely to remain outside of the official kernel (i.e. not for
your list):

o Jan Glauber is working on a fix for the timer issues related
  to running on virtualized CPUs (wall-clock vs. cpu time).

o new zfcp fibre channel driver

o the qeth driver will become GPL soon

o a block device driver for ramdisks shared among virtual
  machines

o driver for crypto hardware

o 'claw' network device driver

	Arnd <><

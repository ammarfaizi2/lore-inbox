Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVDGTIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVDGTIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVDGTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:08:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:40407 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262553AbVDGTHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:07:54 -0400
Date: Thu, 7 Apr 2005 12:06:42 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Cc: stable@kernel.org
Subject: Linux 2.6.11.7
Message-ID: <20050407190642.GA4044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the -stable patch review cycle is now over, I've released the
2.6.11.7 kernel in the normal kernel.org places.  Yes, I'm still using
bk for this release, as we don't have any other system in place just
yet...

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.6 and 2.6.11.7, as it is small enough to do so.

thanks,
 
greg k-h

------
 Makefile                      |    2 +-
 arch/ia64/kernel/fsys.S       |    4 +++-
 arch/ia64/kernel/signal.c     |    3 ++-
 arch/um/kernel/skas/uaccess.c |    3 ++-
 drivers/i2c/chips/eeprom.c    |    3 ++-
 fs/jbd/transaction.c          |    6 +++---
 lib/rwsem-spinlock.c          |   42 ++++++++++++++++++++++++++----------------
 lib/rwsem.c                   |   16 ++++++++++------
 net/ipv4/tcp_input.c          |    5 ++++-
 net/ipv4/xfrm4_output.c       |   12 ++++++------
 net/ipv6/xfrm6_output.c       |   12 ++++++------
 sound/core/timer.c            |    5 ++++-
 12 files changed, 69 insertions(+), 44 deletions(-)


Summary of changes from v2.6.11.6 to v2.6.11.7
==============================================

Amy Griffis:
  o fix ia64 syscall auditing

David Howells:
  o rwsem fix

David S. Miller:
  o Fix BIC congestion avoidance algorithm error

Greg Kroah-Hartman:
  o Linux 2.6.11.7

Jean Delvare:
  o I2C: Fix oops in eeprom driver

Paolo 'Blaisorblade' Giarrusso:
  o [patch 1/1] uml: va_copy fix

Patrick McHardy:
  o Do not hold state lock while checking size

Stephen C. Tweedie:
  o Prevent race condition in jbd

Takashi Iwai:
  o Fix Oops with ALSA timer event notification


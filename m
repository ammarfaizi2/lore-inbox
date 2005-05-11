Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVEKW7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVEKW7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVEKW5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:57:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:46297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261744AbVEKWzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:55:53 -0400
Date: Wed, 11 May 2005 15:54:49 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.11.9
Message-ID: <20050511225448.GA12357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a recently announced security issue with the current kernel, we
(the -stable team) are announcing the release of the 2.6.11.9 kernel.
It contains:
	- a fix for the posted problem
	- a revert of a patch in the last release that caused issues
	  with partitions (the bk changelog shows this as a i2c issue,
	  but that is a mistake as you can see from the real patch.)
	- addition of the SecurityBugs documentation
	- another security related fix that is already in 2.6.12-rc4.

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.8 and 2.6.11.9, as it is small enough to do so.


thanks,

greg k-h

----------

 Documentation/SecurityBugs |   38 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                |    5 +++++
 Makefile                   |    2 +-
 REPORTING-BUGS             |    4 ++++
 fs/binfmt_elf.c            |    4 ++--
 fs/partitions/msdos.c      |    5 -----
 kernel/exit.c              |    2 --
 7 files changed, 50 insertions(+), 10 deletions(-)



Summary of changes from v2.6.11.8 to v2.6.11.9
==============================================

Andrew Morton:
  o Remove bogus BUG() in kernel/exit.c

Chris Wright:
  o Security contact info

Greg Kroah-Hartman:
  o Cset exclude:
    khali@linux-fr.org[gregkh]|ChangeSet|20050430010004|65088
  o fix Linux kernel ELF core dump privilege elevation
  o Linux 2.6.11.9

Jean Delvare:
  o I2C: Fix incorrect sysfs file permissions in it87 and via686a
    drivers


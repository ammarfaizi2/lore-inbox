Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTI3Kaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTI3Kai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:30:38 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:42952 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261250AbTI3Kah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:30:37 -0400
Date: Tue, 30 Sep 2003 12:28:39 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200309301028.h8UASdTI004280@burner.fokus.fraunhofer.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel includefile bug not fixed after a year :-(
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A year after I did report this inconsistency, it is still not fixed

If include/scsi/scsi.h is included without __KERNEL__ #defined, then this
error message apears.

/usr/src/linux/include/scsi/scsi.h:172: parse error before "u8"
/usr/src/linux/include/scsi/scsi.h:172: warning: no semicolon at end of struct 
or union
/usr/src/linux/include/scsi/scsi.h:173: warning: data definition has no type or 
storage class

Is there no interest in user applications for kernel features or is there just
no kernel maintainer left over who makes the needed work?


Hints:

-	A type named "u8" is superfluous (even with __KERNEL__ #defined)
	because we have a standard type uint8_t

-	Kernel include files should be checked for use compliance with level 
	compilations on a regular base. It is the duty of the persons who
	make changes to make sure that their changes don't break things.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily

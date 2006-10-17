Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWJQOsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWJQOsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWJQOsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:48:41 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:23505 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751129AbWJQOsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:48:40 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de>
Date: Tue, 17 Oct 2006 16:45:43 +0200
To: linux-kernel@vger.kernel.org
Cc: Me@fokus.fraunhofer.de
Subject: Linux ISO-9660 Rock Ridge bug needs fix
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while working on better ISO-9660 support for the Solaris Kernel,
I recently enhanced mkisofs to support the Rock Ridge Standard version 1.12
from 1994.

The difference bewteen version 1.12 and 1.10 (this is what previous
mkisofs versions did implement) is that the "PX" field is now 8 Byte
bigger than before (44 instead of 36 bytes).

As Rock Ridge is a protocol that implements a list of size tagged fields,
this change in mkisofs should not be a problem and in fact is not for Solaris
or FreeBSD. As Linux does not implement Rock Rige correctly, Linux will
reject CDs/DVDs that have been created by a recent mkisofs.

As Linux will completely disable RR because of this bug, it must be called
a showstopper bug that needs immediate fixing and that also needs to be 
backported.

The recent version of cdrtools that include the new mkisofs is located at:

ftp://ftp.berlios.de/pub/cdrecord/alpha/cdrtools-2.01.01a18-pre.tar.bz2

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSHRPzS>; Sun, 18 Aug 2002 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSHRPzS>; Sun, 18 Aug 2002 11:55:18 -0400
Received: from host194.steeleye.com ([216.33.1.194]:6155 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315267AbSHRPzR>; Sun, 18 Aug 2002 11:55:17 -0400
Message-Id: <200208181559.g7IFxE604241@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW SUBARCHITECTURE FOR 2.5.31] support for NCR voyager 
 (3/4/5xxx series)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Aug 2002 10:59:14 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
SMP microchannel non-PC architecture.

The only change since 2.5.31 is that the code will now boot with a non-zero 
boot cpu id (previously current->cpu was being initialised too late).

The patch is in two parts:  The i386 sub-architecture split is separated from 
the addition of the voyager components

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.31.diff (108k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.31.diff (146k)

You must apply the split diff before applying the voyager one.

These two patches are also available as separate bitkeeper trees (the voyager 
tree is a superset of the arch-split one):

http://linux-voyager.bkbits.net/voyager-2.5
http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHMIMK>; Tue, 13 Aug 2002 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSHMIMK>; Tue, 13 Aug 2002 04:12:10 -0400
Received: from 62-190-217-138.pdu.pipex.net ([62.190.217.138]:6660 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S313070AbSHMIMJ>; Tue, 13 Aug 2002 04:12:09 -0400
Date: Tue, 13 Aug 2002 09:22:40 +0100
From: jbradford@dial.pipex.com
Message-Id: <200208130822.g7D8Me92000218@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: (More about) IDE powersaving
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

Sorry to bring this up again, but I think that the current behavior of requiring a manual device reset, for some disks that are put to sleep with hdparm -Y is definitely wrong - I mailed Mark Lord, (the hdparm maintainer) who said:

> Yes, I agree:  the IDE driver should automatically
> attempt a "device reset" at some point when trying
> to communicate with a drive that is not responding
> (eg. due to "hdparm -Y" or whatever).

Is this a known issue with some interface/drive combinations?  I can only reproduce it with a Maxtor disk on a PIIX3 interface.  After being put to sleep, the disk never responds until it is manually reset with hdparm -w.

I know you can achieve a similar effect by putting the disk in to standby, but putting it to sleep will reduce energy consumption, (by a tiny amount).

John.

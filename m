Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263368AbSJFKE4>; Sun, 6 Oct 2002 06:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263369AbSJFKE4>; Sun, 6 Oct 2002 06:04:56 -0400
Received: from 62-190-201-115.pdu.pipex.net ([62.190.201.115]:6405 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263368AbSJFKEz>; Sun, 6 Oct 2002 06:04:55 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210061019.g96AJ9KA001206@darkstar.example.net>
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
To: masterlee@digitalroadkill.net (GrandMasterLee)
Date: Sun, 6 Oct 2002 11:19:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1033874298.4209.5.camel@localhost> from "GrandMasterLee" at Oct 05, 2002 10:18:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux is not allowed to address LUNs out of sequence, so searching for
> > further LUN numbers stops after 0, since 2 is the next one. 

That's not true:

CONFIG_SCSI_REPORT_LUNS:

If you want to build with SCSI REPORT LUNS support i the kernel, say Y here.
The REPORT LUNS command is useful for devices (such as disk arrays) with large numbers of LUNs where the LUN values are not contiguous (sparse LUN).
REPORT LUNS scanning is done only for SCSI-3 devices.

> > Is there a way to resolve this, either at the driver level, IMHO the
> > place it *should* happen. At the storage level, the place that it could
> > also happen, or in the Kernel?

This is new in 2.5.x

John.

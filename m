Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWDLJAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWDLJAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDLJAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:00:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31369 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751011AbWDLJAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:00:50 -0400
Subject: Re: libata-pata works on ICH4-M
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
References: <443B9EBB.6010607@gmx.net>
	 <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 10:09:50 +0100
Message-Id: <1144832990.1952.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-11 at 20:46 +0200, Jan Engelhardt wrote:
> So libata has the overhead of using SCSI commands? At least 
> that's what it suggests to the normal user.

libata issues standard ATA commands to disks and CF cards, and ATAPI to
other devices. The current tree knows how to use LBA28 commands
opportunistically so its generating basically the same command stream as
the old IDE layer


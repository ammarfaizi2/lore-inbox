Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTDOQn0 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbTDOQnZ 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:43:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3520
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261805AbTDOQnZ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:43:25 -0400
Subject: Re: warnings when booting 2.5.67 or 2.4.21-pre7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Staudenmayer <eggdropfan@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030415162652.80297.qmail@web41813.mail.yahoo.com>
References: <20030415162652.80297.qmail@web41813.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050422227.27744.70.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 16:57:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 17:26, Christian Staudenmayer wrote:
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x10 { SectorIdNotFound }, LBAsect=0, sector=0

Boggle. We asked your drive to do something and it said "sector 0 doesnt
exist". Clearly it did because it then worked fine.

> hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: task_no_data_intr: error=0x04 { DriveStatusError }

These others look ok. DriveStatusError is generally "I dont know that
command". Its noise as we ask old drives about newer stuff. It wants
quitening eventually.



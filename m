Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUH1UhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUH1UhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266677AbUH1Ug0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:36:26 -0400
Received: from the-village.bc.nu ([81.2.110.252]:5504 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267992AbUH1URh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:17:37 -0400
Subject: Re: Need help in mounting two-LUN atapi flash card reader
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karthi Jothi <karthi@onspecinc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <006d01c4897d$ab8bce00$1000a8c0@websys>
References: <006d01c4897d$ab8bce00$1000a8c0@websys>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093353480.2810.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:15:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-24 at 02:57, Karthi Jothi wrote
> Need help in mouting two-LUN atapi flash card reader. 
> 1.  The device used for mounting is a Atap flash card reader and it is not
> an USB device.  It uses 40-PIN ide connector and cable. It is connected as
> secondary master to the linux system.

The ide-scsi driver handles multiple luns but in 2.4 the default
behaviour most vendors shipped was "do not probe extra luns". There is a
scsi black/whitelist table that is used to vary the behaviour or the
max_scsi_luns option to the scsi layer should also work.

2.6 is meant to be a bit more intelligent about this and my Nakamichi CD
changer seems to do the right thing.

Alan


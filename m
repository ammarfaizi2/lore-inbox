Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUIZXY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUIZXY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 19:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIZXY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 19:24:27 -0400
Received: from bianca.affordablehost.com ([216.46.192.8]:33999 "EHLO
	bianca.affordablehost.com") by vger.kernel.org with ESMTP
	id S264980AbUIZXYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 19:24:25 -0400
Date: Sun, 26 Sep 2004 16:22:28 -0700
From: "Randy.Dunlap" <rddunlap@xenotime.net>
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help Requested with patching "drivers/pci/quirks.c"
Message-Id: <20040926162228.02a85a63.rddunlap@xenotime.net>
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C3F@psexc03.nbnz.co.nz>
References: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C3F@psexc03.nbnz.co.nz>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bianca.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 11:06:15 +1200 Roberts-Thomson, James wrote:

| Looking at the quirks.c code, I can see functions like
| "asus_hides_smbus_hostbridge" and "asus_hides_smbus_lpc", which use a lookup
| table to determine whether or not to set the appropriate flag and toggle the
| PCI bits to enable the SMbus.  Obviously, I need to include the appropriate
| checks (and associated entries in the pci_fixups struct) to get this applied
| to my machine at kernel load time (I've seen some patches on the lkml
| recently that seem to do exactly this - quite happy to try and add this
| functionality).  For example, here is an extract from a similar patch:
| 
| +        if ((dev->device == PCI_DEVICE_ID_INTEL_82865_HB) &&
| +            (dev->subsystem_device == 0x12bc)) /* HP D330L */
| +                asus_hides_smbus = 1;
| 
| My problem is that I don't understand how the "dev->device" and
| "dev->subsystem_device" values are obtained.  Where/How do I read the actual
| values from my machine so that I can add them into the code tables?

Try "lspci -n".

| Any help would be appreciated; as would "cc"ing replies directly to me (I
| don't subscribe to lkml, and may miss replies when searching via MARC).
| 
| 
| This communication is confidential and may contain privileged material.
| If you are not the intended recipient you must not use, disclose, copy or retain it.
| If you have received it in error please immediately notify me by return email
| and delete the emails.

N.B.:  I may have received this non-confidential email in error.

--
~Randy

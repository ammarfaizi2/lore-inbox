Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVBORXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVBORXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVBORGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:06:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48000 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261796AbVBORET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:04:19 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and
	give	dev=/dev/hdX as device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42115DA2.6070500@osdl.org>
References: <1108426832.5015.4.camel@bastov>
	 <1108434128.5491.8.camel@bastov>  <42115DA2.6070500@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108486952.4618.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Feb 2005 17:02:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-02-15 at 02:25, Randy.Dunlap wrote:
> It means:  don't use the ide-scsi driver.  Support for it is
> lagging (not well-maintained) because it's really not needed for
> burning CDs.  Just use the ide-cd driver (module) and
> specify the CD burner device as /dev/hdX.

This information is unfortunately *WRONG*. The base 2.6 ide-cd driver is
vastly inferior to ide-scsi. The ide-scsi layer knows about proper error
reporting, end of media and other things that ide-cd does not.

The -ac ide-cd knows some of the stuff that ide-cd needs to and works
with various drive/disk combinations the base code doesn't but ide-scsi
still handles CD's better.

Alan


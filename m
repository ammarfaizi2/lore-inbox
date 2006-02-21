Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWBUTIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWBUTIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 14:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWBUTIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 14:08:46 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:13754 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932539AbWBUTIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 14:08:45 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: MMCONFIG broken on Tyan K8WE [was: Fusion MPT driver does not detect controller]
Date: Tue, 21 Feb 2006 12:08:38 -0700
User-Agent: KMail/1.8.3
Cc: linux-pci@atrey.karlin.mff.cuni.cz, stathis@ims.tuwien.ac.at,
       l.schimmer@cgv.tugraz.at
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602211208.38777.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 2.6.15.4 bug is languishing in bugzilla:

    http://bugzilla.kernel.org/show_bug.cgi?id=6060

Devices behind a PCI-X bridge are invisible unless the submitter
uses "pci=nommconf".  The devices worked in 2.6.13.5, because we
always disabled mmconfig for AMD CPUs then.  But now it's broken.

I also found this problem report, which may be the same problem:
    http://lists.debian.org/debian-amd64/2006/02/msg00119.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTLIDRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTLIDRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:17:15 -0500
Received: from fmr05.intel.com ([134.134.136.6]:9621 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262674AbTLIDRO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:17:14 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Retriving PCI driver data from file ops
Date: Mon, 8 Dec 2003 19:17:09 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DFCB@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Retriving PCI driver data from file ops
Thread-Index: AcO9/Dico5TzENP6STGd8cE4RkmN6AABVdaA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "James Lamanna" <jamesl@appliedminds.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Dec 2003 03:17:10.0438 (UTC) FILETIME=[EEEF5460:01C3BE02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James Lamanna
> 
> Is there an elegant way to retrieve a pointer registered with
> pci_set_drvdata() within an open fops function?
> Or am I forced to make it a static variable?

Normally how you do this is that during open(), you associate
your 'struct file's priv pointer to the specific instance of the device
you are opening; in that instance structure you keep pointers to
the 'struct pci_device' for your access needs.

See for a more complete reference:

http://kernel-janitor.sourceforge.net/kernel-janitor/docs/driver-howto.html#3.2.2

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

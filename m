Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUJEFNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUJEFNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbUJEFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:13:50 -0400
Received: from fmr12.intel.com ([134.134.136.15]:58301 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268781AbUJEFNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:13:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Mon, 4 Oct 2004 22:13:41 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 SGI Altix I/O code reorganization
Thread-Index: AcSqXa/bEnQdG8rtS+WQEoPSntFttQAOz/hg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Pat Gefre" <pfg@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2004 05:13:42.0499 (UTC) FILETIME=[14DDEB30:01C4AA9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm ok with the delete/add of most of the SGI
specific files (maybe it still isn't perfect yet,
but it may be close enough to take it, and then
clean up with some small patches).

But you seem to be touching some files outside of pure SGI
stuff.  These two are a bit of a concern:

  include/asm-ia64/io.h
  arch/ia64/pci/pci.c

These others are outside of my area (well I *might* push
the drivers that are only used by SGI ... but hotplug
and qla1280 are definitely not mine).  So they need to be
split out into separate patches.

  drivers/char/mmtimer.c
  drivers/char/snsc.c
  drivers/ide/pci/sgiioc4.c
  drivers/pci/hotplug/Kconfig
  drivers/scsi/qla1280.c
  drivers/serial/sn_console.c

-Tony

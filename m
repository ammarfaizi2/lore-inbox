Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVA0AnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVA0AnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVA0AW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:22:57 -0500
Received: from mail0.lsil.com ([147.145.40.20]:24773 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262494AbVAZXXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:23:32 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5705B83A31@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'Patrick Mansfield'" <patmans@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Wed, 26 Jan 2005 18:23:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> And what do you mean "different implementations for /sbin/hotplug"?
> What distros do not use the standard "linux-hotplug" type 
> scripts, or if not the scripts, the same functionality?

You are right, even though distributions (I checked Red Hat and SuSE) have
different /sbin/hotplug scripts (e.g., SuSE 9.2 will not execute files from
/etc/hotplug.d whereas Red Hat does) udev will be invoked in all cases,
which will take care of creating device nodes.

But our concern is that how would the applications get the cue that udev has
actually created the nodes for the new devices? 

Make sure an agent is called after the, e.g., scsi agents are executed from
/etc/hotplug directory (which happen to be scsi.agent, scsi_device.agent,
scsi_host.agent in one and only scsi.agent in other distribution), by
writing an rc like script?

Or more likely, by placing our agent in /etc/dev.d directory. Unfortunately,
there seems be not a consensus here as well. On system has "default" and
"net" directories and other has "block", "input", "net", "tty"?


Thanks

--------------------------------
Atul Mukker
Architect, RAID Drivers and BIOS
LSI Logic Corporation

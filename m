Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUE1OnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUE1OnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUE1OnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:43:11 -0400
Received: from fmr05.intel.com ([134.134.136.6]:11955 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263079AbUE1OnH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:43:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: scsihosts kernel param broken?
Date: Fri, 28 May 2004 22:42:55 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F842DB1E7@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: scsihosts kernel param broken?
Thread-Index: AcREcZblQqMp3OzKTMe2NnKg2bzSHwAUCmjA
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Robin H. Johnson" <robbat2@orbis-terrarum.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 May 2004 14:42:56.0175 (UTC) FILETIME=[1057CBF0:01C444C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin H. Johnson wrote:
> Hi,
> 
> After tweaking my kernel today and moving my SCSI controller
> drivers into the kernel instead of using them as modules, I
> wanted to use the scsihosts kernel parameter as described in
> filesystems/devfs/README, to tweak the order of my 3ware
> (3w-xxxx) and Adaptec (aic79xx) [two controllers] drives.
> 
> I'd like:
> scsihosts=aic79xx:3w-xxxx:aic79xx
> But the aic79xx code is running first, and leaving all my 3ware stuff
> to last. 
> 
> What's broken here?

Which kernel? I think it should be removed since 2.5.73

ChangeSet@1.1046.234.10, 2003-06-06 09:01:05-04:00, hch@lst.de
  [PATCH] kill scsihosts= boot parameter

  This feature is seriously racy, and doesn't work under many
  circumstances.  As we have proper ways to find devices by their
  their locical naming (UUID, fs label) or physical connectivity
  (scsidev, sysfs) it shouldn't be nessecary anymore.
 
> Please CC me with responses, as I usually just lurk via the
> mail archives.



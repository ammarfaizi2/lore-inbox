Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTDLFYR (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 01:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbTDLFYR (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 01:24:17 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:63208 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263169AbTDLFYQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 01:24:16 -0400
Date: Fri, 11 Apr 2003 23:35:14 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: dougg@torque.net, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SATA on SAS [was: ATAPI cdrecord issue 2.5.67]
Message-ID: <2301930000.1050125714@aslan.btc.adaptec.com>
In-Reply-To: <3E97632F.1090104@torque.net>
References: <3E97632F.1090104@torque.net>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Spinning this discussion another way, with Serial Attached SCSI
> (SAS) real SATA disk drives can be attached to SAS host bus adapters
> (HBAs). For that matter cdwriters that use MMC (scsi instruction
> set) over ATAPI could be SATA devices connected to a SAS HBA.

Actually, SAS does not cover the case of a SAS HBA connected directly
to a SATA device.  You must through an expander since SATA devices do
not speak STP and it is the expander that provides the STP -> SATA conversion
on the backend.  The spec does not preclude a SAS HBA speaking SATA
directly, but in doing so, it will be operating outside of the SAS
spec.

--
Justin


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUBJSmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUBJSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:42:31 -0500
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:1447 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S266173AbUBJSmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:42:21 -0500
Date: Tue, 10 Feb 2004 10:25:13 -0800
From: Andrew Vasquez <praka@users.sourceforge.net>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: veeresh <vanami@india.hp.com>
Subject: Re: Kernel panic on Redhat Linux AS2.1 with QLogic 2342 HBA
Message-ID: <20040210182513.GA114@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	veeresh <vanami@india.hp.com>
References: <005601c3ef94$f8c9d140$3bda4c0f@nt21859>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005601c3ef94$f8c9d140$3bda4c0f@nt21859>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, veeresh wrote:

> Kernel panic information:
> kernel BUG at /usr/src/linux-2.4/include/asm/pci.h:145!
> invalid operand: 0000
> Kernel 2.4.9-e.25smp
> CPU: 2
> EIP: 0010:[<f8891658>] Tainted: P
> EFLAGS: 00010086
> EIP is at qla2x00_64bit_start_scsi [qla2300] 0x498

One of the scatter-gather entries of a SCSI command was NULL.  Is any
of the software you are running preparing SCSI commands and sending
them down via SG perhaps?  What type of I/O is occuring when the
failure occurs?

Regards,
Andrew Vasquez
QLogic Corporation

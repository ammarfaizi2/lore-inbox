Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTKRFxB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 00:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTKRFxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 00:53:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59038 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262094AbTKRFw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 00:52:58 -0500
Date: Mon, 17 Nov 2003 21:52:52 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Amit Patel <patelamitv@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: scsi_report_lun_scan bug?
Message-ID: <20031117215252.A25366@beaverton.ibm.com>
References: <20031118024833.7619.qmail@web13006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031118024833.7619.qmail@web13006.mail.yahoo.com>; from patelamitv@yahoo.com on Mon, Nov 17, 2003 at 06:48:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 06:48:33PM -0800, Amit Patel wrote:
> Hi,
> 
> I am using 2.6-test9-mm3. I noticed while doing
> scsi_report_lun_scan(scsi_scan.c:891) the data
> returned is assigned(scsi_scan.c:993) to signed char
> array which causes the reported number of luns to be
> huge while calculating num_luns to scan. Is there any
> particular reason to be data is signed or just a bug?
> 
> I changed it to unsigned char and it seems to work
> fine. I have attached a diff of scsi_scan.c. Let me
> know if I am missing something.

I don't see why making it signed or unsigned would make any difference.

What values did you see before and after your patch?

It should really be a u8, since it is a pointer to an array of bytes.

(And all the scsi_cmd[]'s should be u8.)

-- Patrick Mansfield

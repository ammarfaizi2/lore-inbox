Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbULCR2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbULCR2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbULCR2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:28:19 -0500
Received: from lists.us.dell.com ([143.166.224.162]:55006 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262388AbULCRPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:15:17 -0500
Date: Fri, 3 Dec 2004 11:14:02 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041203171402.GB19714@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA70@exa-atlanta> <20041203171101.GA19714@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203171101.GA19714@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 11:11:01AM -0600, Matt Domsch wrote:
> Doing it within the driver means you've got to release a new driver
> for each affected OS, to avoid having to update the userspace app on
> each OS.  I claim it's much easier to update a userspace lib/app than
> it is to update a driver on each installed system.

And, you're going to have to update the userspace lib/app to add the
new ioctl()-invocation to it anyhow.  So take the hit *only* there and
make it use either /sys or /proc, whichever is available, no kernel
changes.  Yes?

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbULCRO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbULCRO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbULCRO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:14:57 -0500
Received: from lists.us.dell.com ([143.166.224.162]:50910 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262388AbULCRM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:12:28 -0500
Date: Fri, 3 Dec 2004 11:11:01 -0600
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
Message-ID: <20041203171101.GA19714@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA70@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CA70@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 10:29:29AM -0500, Bagalkote, Sreenivas wrote:
> I agree. The sysfs method would have been the most logical way of doing it.
> But then application becomes sysfs dependent. We really cannot do that.

Why?  With my efibootmgr (a userspace app like your
megalib/megamgr/megamon), it looks for the existance of
/sys/whatever/, and then operates with that if it is present.  Else it
looks for the existance of /proc/whatever (in your case
/proc/scsi/scsi) and does likewise.  No driver ioctl needed.
 
> Given that we have to do it from within the driver, is whatever I am doing
> right?

Doing it within the driver means you've got to release a new driver
for each affected OS, to avoid having to update the userspace app on
each OS.  I claim it's much easier to update a userspace lib/app than
it is to update a driver on each installed system.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

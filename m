Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbULIRJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbULIRJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULIRIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:08:31 -0500
Received: from 216-99-218-173.dsl.aracnet.com ([216.99.218.173]:46792 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261555AbULIRHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:07:47 -0500
Date: Thu, 9 Dec 2004 09:04:55 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@steeleye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Matt Domsch'" <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041209170455.GA6919@us.ibm.com>
References: <0E3FA95632D6D047BA649F95DAB60E57057A1AEA@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57057A1AEA@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 09:11:15AM -0500, Mukker, Atul wrote:

> 4. Since megaraid driver does not know about these changes, it cannot notify
> kernel.

> 8. So, all driver has to do to assist applications is to provide the logical
> drive number to scsi address mapping. Application would say, hey! I
> added/removed logical drive number 5, driver reverts, here is the scsi
> address for it "host:2, channel:5, target:5 lun:0" :-)

How does the driver supply the mapping if it does not know about the
"change"? Is it reserving or telling user space the hctl that will be
used?

If so, why can't the driver call scsi_add_device(h,c,t,l) after the ioctl
to create the logical drive completes?

Though I am all for using hotplug to initiate scanning from user space.

-- Patrick Mansfield

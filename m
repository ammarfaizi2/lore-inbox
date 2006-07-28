Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWG1C3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWG1C3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWG1C3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:29:08 -0400
Received: from msr20.hinet.net ([168.95.4.120]:20182 "EHLO msr20.hinet.net")
	by vger.kernel.org with ESMTP id S932572AbWG1C3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:29:06 -0400
Message-ID: <045d01c6b1ed$8dfecf50$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Neil Horman" <nhorman@tuxdriver.com>,
       "John W. Linville" <linville@tuxdriver.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>,
       <jgarzik@pobox.com>
References: <1154030065.5967.15.camel@localhost.localdomain> <20060727125421.GB22935@tuxdriver.com> <20060727130626.GB8794@hmsreliant.homelinux.net>
Subject: Re: [PATCH] Create IP100A Driver
Date: Fri, 28 Jul 2006 10:28:47 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All:

There are release note of ip100a.c, that is also different of ip100a.c and
sundance.c:

version        descriptions
---------------------------------------------------------------------- 
[1.21]          1. Support for Mandrake10.x
[2006/5/4]

version        descriptions
---------------------------------------------------------------------- 
[1.20]          1. Solve host error problem in alpha embedded system.
[2005/12/9]

version        descriptions
---------------------------------------------------------------------- 
[1.19]          1. After 2.6.11, changed slot_name to pci_name().
[2005/8/3]

version        descriptions
---------------------------------------------------------------------- 
[1.18]          1. Modify driver for kernel after 2.6.10
[2005/5/6]

version        descriptions
---------------------------------------------------------------------- 
[1.17]          1. Fix host error when repeatly down/up IP100A
[2005/4/20]

version        descriptions
---------------------------------------------------------------------- 
[1.16a]          1. Remove support for kernel 2.2.x in readme.txt
[2005/4/15]

version        descriptions
---------------------------------------------------------------------- 
[1.16]          1. Support for kernel 2.6.x
[2004/10/22]

version        descriptions
---------------------------------------------------------------------- 
[1.15b]         1. Change Makefile for "Unresolved symbols".
[2004/08/30]    2. Remove depmod -a in readme.txt

version        descriptions
---------------------------------------------------------------------- 
[1.15a]         1. Updata Readme.txt. add #depmod -a
[2004/08/27]

version        descriptions
---------------------------------------------------------------------- 
[1.15]         1. Mask MemBaseAddr and IOBaseAddr bit 0 to 6.
[2004/08/18]   2. Updata Readme.txt section C to more detail.

version        descriptions
---------------------------------------------------------------------- 
[1.14a]         1. Add how to change speed in readme.txt
[2004/08/18]

version        descriptions
---------------------------------------------------------------------- 
[1.14]         1. Fix parameter "media" for change speed function.
[2004/08/17]

version        descriptions
---------------------------------------------------------------------- 
[1.13]         1. Fix LED BUG when IC run global reset.
[2004/07/24]

version        descriptions
---------------------------------------------------------------------- 
[v1.12]        1. Change Vendor from Sundance to IC Plus
[2004/04/13]   2. Add Device ID 0200


version     descriptions
----------------------------------------------------------------------
[v1.11]        1. Create from sundance.c(dlh5x-1.10.tgz).
[2004/04/08]   2. Start phy id scan at id 0.
---------------------------------------------------------------------- 

----- Original Message ----- 
From: "Neil Horman" <nhorman@tuxdriver.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: "Jesse Huang" <jesse@icplus.com.tw>; <linux-kernel@vger.kernel.org>;
<netdev@vger.kernel.org>; <akpm@osdl.org>; <jgarzik@pobox.com>
Sent: Thursday, July 27, 2006 9:06 PM
Subject: Re: [PATCH] Create IP100A Driver


On Thu, Jul 27, 2006 at 08:54:27AM -0400, John W. Linville wrote:
> On Thu, Jul 27, 2006 at 03:54:25PM -0400, Jesse Huang wrote:
> > From: Jesse Huang <jesse@icplus.com.tw>
> >
> > This is the first version of IP100A Linux Driver.
>
> One general comment is that your patch is whitespace-damaged,
> undoubtedly mangled by your mailer.  I would suggest that you use
> a text- or curses-based mailer (like mutt or even mail) for sending
> patches, but I'm sure there are graphical mailers that can be trained
> to not be "too smart".
>
> > +static struct pci_device_id ipf_pci_tbl[] __devinitdata = {
> > +       {0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
> > +       {0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
> > +       {0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
> > +       {0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3},
> > +       {0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
> > +       {0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
> > +       {0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> > +       {0,}
> > +};
>
> This PCI ID table is identical to the one in the sundance driver.
> What advantage does this driver offer over sundance?
>
> Thanks,
>
> John

Having read Johns comment, I went back and looked again, and in fact the
entire
driver appears to be a copy of the sundance code.  The most significant
changes
I can see is that the header includes were moved to ipf.h, and the
non-standard
data types (UINT/UCHAR/etc) were added.

Regards
Neil

> -- 
> John W. Linville
> linville@tuxdriver.com
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/



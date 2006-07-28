Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWG1CXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWG1CXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWG1CXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:23:46 -0400
Received: from msr24.hinet.net ([168.95.4.124]:35970 "EHLO msr24.hinet.net")
	by vger.kernel.org with ESMTP id S1750968AbWG1CXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:23:45 -0400
Message-ID: <044901c6b1ec$d0f5b680$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>,
       <jgarzik@pobox.com>
References: <1154030065.5967.15.camel@localhost.localdomain> <20060727125421.GB22935@tuxdriver.com>
Subject: Re: [PATCH] Create IP100A Driver
Date: Fri, 28 Jul 2006 10:23:30 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John:

I will try mutt or mail when i want to send next patch. Most different of
ip100a.c
and sundance.c are almost same only fix some bugs. The different of ip100a
and ip100 is in phy. We can use one driver to support those two device, I
want
to know what is better for kernel:

1. Only updata sundance.c to support IP100A
2. Release ip100a.c which support ip100(sundance) to kernel 2.6.x and ask to
remove sundance.c.
3. Release ip100a.c with sundance.c both to kernel 2.6.x

We hope to use IP100a.c as our product driver, so 2. and 3. will better for
IC Plus. But we will still follow your suggestion, if you feel 1. was better
for kernel.

Jesse
----- Original Message ----- 
From: "John W. Linville" <linville@tuxdriver.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>; <jgarzik@pobox.com>
Sent: Thursday, July 27, 2006 8:54 PM
Subject: Re: [PATCH] Create IP100A Driver


On Thu, Jul 27, 2006 at 03:54:25PM -0400, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
>
> This is the first version of IP100A Linux Driver.

One general comment is that your patch is whitespace-damaged,
undoubtedly mangled by your mailer.  I would suggest that you use
a text- or curses-based mailer (like mutt or even mail) for sending
patches, but I'm sure there are graphical mailers that can be trained
to not be "too smart".

> +static struct pci_device_id ipf_pci_tbl[] __devinitdata = {
> +       {0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
> +       {0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
> +       {0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
> +       {0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3},
> +       {0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
> +       {0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
> +       {0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> +       {0,}
> +};

This PCI ID table is identical to the one in the sundance driver.
What advantage does this driver offer over sundance?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com



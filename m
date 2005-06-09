Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVFIVVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVFIVVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVFIVVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:21:04 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44450 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262478AbVFIVUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:20:25 -0400
Date: Thu, 9 Jun 2005 23:18:43 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Hutchings <info@a-wing.co.uk>
Cc: linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050609211843.GA5630@electric-eye.fr.zoreil.com>
References: <42A621BC.7040607@a-wing.co.uk> <20050607225755.GB30023@electric-eye.fr.zoreil.com> <42A62BD0.7090709@a-wing.co.uk> <20050608225157.GA16107@electric-eye.fr.zoreil.com> <42A82FE3.3080603@a-wing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A82FE3.3080603@a-wing.co.uk>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Hutchings <info@a-wing.co.uk> :
[...]
> Tried it, it didn't detect the sis190 in this board so I changed the 
> PCI_ID lines to:
> static struct pci_device_id sis190_pci_tbl[] __devinitdata = {
>    { 0x1039, 0x0190, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>    { 0,},
> };

/me scratches head

The figures look the same. I must be tired.

> This then detected it but caused a soft lockup on modprobe with a dump 
> which I have attached here.  I have also attched lspci -vvv and -xxx for 
> you.

Right, there was a bug. I am not sure the fix will really fix though.

See the patch of the day:

http://www.fr.zoreil.com/people/francois/misc/20050610-2.6.12-rc-sis190-test.patch

Please add a dmesg as well if something goes wrong.

> FYI, I know the general spec for a sis190 is 1000MBit but the one on 
> this mobo is just a 10/100MBit

The driver enables nearly everything via the mii. With some luck it will
be enough to postpone the link management revamp until at least one (1)
packet has proceeded through the driver.

Thanks for your testing.

--
Ueimor

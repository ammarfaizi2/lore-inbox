Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVFJKaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVFJKaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFJK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:28:26 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15744 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262379AbVFJK2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:28:04 -0400
Message-ID: <42A96BF9.2050608@jp.fujitsu.com>
Date: Fri, 10 Jun 2005 19:31:21 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 03/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com> <42A83B6D.8010703@jp.fujitsu.com> <20050609172035.GD24611@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050609172035.GD24611@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Jun 09, 2005 at 09:51:57PM +0900, Hidetoshi Seto wrote:
> 
>>+	switch (dev->hdr_type) {
>>+	case PCI_HEADER_TYPE_NORMAL: /* 0 */
>>+		pci_read_config_word(dev, PCI_STATUS, &status);
>>+		break;
>>+	case PCI_HEADER_TYPE_BRIDGE: /* 1 */
>>+		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
>>+		break;
>>+	case PCI_HEADER_TYPE_CARDBUS: /* 2 */
>>+	default:
>>+		BUG();
> 
> If somebody plugs a cardbus card into an ia64 machine, we BUG()?
> Unacceptable.  Just return 0 if you don't know what to do with a
> particular device.

Sure, you are right. I'll fix it.

Thanks,
H.Seto


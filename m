Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVCDCJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVCDCJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVCDCGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:06:17 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:7584 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262799AbVCDCBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:01:51 -0500
Message-ID: <4227C1F1.6040508@jp.fujitsu.com>
Date: Fri, 04 Mar 2005 11:03:29 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com> <20050301144211.GI28741@parcelfarce.linux.theplanet.co.uk> <20050301192711.GE1220@austin.ibm.com> <42255971.4070608@jp.fujitsu.com> <20050302192043.GJ1220@austin.ibm.com>
In-Reply-To: <20050302192043.GJ1220@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
>>If their defaults are no-ops, device
>>maintainers who develops their driver on not-implemented arch should be
>>more careful. 
> 
> Why? People who write device drivers already know if/when they need to
> disable interrupts, and so they already disable if they need it.  

OK, I'll remake them as no-ops.
Nothing will start unless trust in driver folks.

> p.s. I would like to have iochk_read() take struct pci_dev * as an
> argument.  (I could store a pointer to pci_dev in the "cookie" but
> that seems odd).

I'd like to store the pointer and handle all only with the cookie...
Or is it needed to pass different device to iochk_clear() and iochk_read()?


Thanks,
H.Seto


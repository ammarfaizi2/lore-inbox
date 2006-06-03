Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWFCXxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWFCXxB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 19:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWFCXxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 19:53:01 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:13651 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750899AbWFCXxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 19:53:00 -0400
Date: Sat, 03 Jun 2006 17:52:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
In-reply-to: <6inxv-4U2-17@gated-at.bofh.it>
To: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <448220CE.4030709@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6ined-4gY-17@gated-at.bofh.it> <6ined-4gY-21@gated-at.bofh.it>
 <6inee-4gY-23@gated-at.bofh.it> <6ined-4gY-15@gated-at.bofh.it>
 <6inxv-4U2-17@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> For something that generates I/O transactions, it's imperative to
> generate the smallest possible number of transactions.  Furthermore,
> smaller than dword transactions aren't burstable, except at the
> beginning and end of a burst.

Well, theoretically for writes they could be, if the memory region was 
prefetchable and the PCI chipset supported byte merge. It certainly 
isn't optimal however.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


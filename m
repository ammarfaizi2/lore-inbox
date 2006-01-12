Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWALM1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWALM1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWALM1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:27:43 -0500
Received: from aun.it.uu.se ([130.238.12.36]:28880 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1030377AbWALM1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:27:42 -0500
Date: Thu, 12 Jan 2006 13:27:12 +0100 (MET)
Message-Id: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: need for packed attribute
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       oliver@neukum.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 18:38:46 +0000, Russell King wrote:
>> is there any architecture for which packed is required in structures like this:
>> 
>> /* All standard descriptors have these 2 fields at the beginning */
>> struct usb_descriptor_header {
>> 	__u8  bLength;
>> 	__u8  bDescriptorType;
>> };
>
>sizeof(struct usb_descriptor_header) will be 4 on ARM.

I found this surprising, but gcc-3.4.5 for ARM seems to agree with you.

As fas as I can tell, the AAPCS document (v2.03 7th Oct 2005) requires
that a simple "struct foo { unsigned char c; };" should have both size
and alignment equal to 1, but gcc makes them both 4. Do you have any
information about why gcc is doing this on ARM/Linux? Is there an accurate
ABI document for ARM/Linux somewhere?

/Mikael

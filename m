Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUCDOpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUCDOpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:45:35 -0500
Received: from mail6.iserv.net ([204.177.184.156]:39831 "EHLO mail6.iserv.net")
	by vger.kernel.org with ESMTP id S261913AbUCDOp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:45:28 -0500
Message-ID: <40474101.8040306@didntduck.org>
Date: Thu, 04 Mar 2004 09:45:21 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@math.ut.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3: PnPBIOS hangs with S875WP1 BIOS
References: <Pine.GSO.4.44.0403041607410.2398-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0403041607410.2398-100000@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:

>>Try this patch
> 
> 
> Well, it gets a little further. No oops but a different hang:
> 
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f3e90
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x44ba, dseg 0xf0000
> PNPBIOS fault.. attempting recovery.
> double fault, gdt at c0488100 [255 bytes]
> double fault, tss at c0530800
> eip = f7fa1ea6, esp = 00000028

Looks like the BIOS trashed the stack.  I don't think there is anything 
that can be done other than a BIOS update.

--
				Brian Gerst

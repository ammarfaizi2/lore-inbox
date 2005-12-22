Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVLVXTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVLVXTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVLVXTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:19:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:62627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030330AbVLVXTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:19:17 -0500
Date: Thu, 22 Dec 2005 15:18:43 -0800
From: Greg KH <greg@kroah.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] pci device ensure sysdata initialised
Message-ID: <20051222231843.GB1943@kroah.com>
References: <20051220151609.565160d9.akpm@osdl.org> <20051222210628.GA16797@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222210628.GA16797@shadowen.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 09:06:28PM +0000, Andy Whitcroft wrote:
> pci device ensure sysdata initialised
> 
> [Ok, here is a patch to ensure sysdata is valid for all busses.]
> 
> We have been seeing panic's on NUMA systems in pci_call_probe() in
> 2.6.15-rc5-mm2 and -mm3.  It seems that some changes have occured
> to the meaning of the 'sysdata' for a device such that it is no
> longer just an integer containing the node, it is now a structure
> containing the node and other data.  However, it seems that we do not
> always initialise this sysdata before we probe the device.

Yeah, but this patch is just papering over that fact :(

In fact, you will not put these devices on the proper node with this
patch, right?  So I don't think it is what you want.

thanks,

greg k-h

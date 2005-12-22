Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVLVXnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVLVXnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVLVXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:43:33 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:36369 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030377AbVLVXnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:43:32 -0500
Message-ID: <43AB3A1C.5070606@shadowen.org>
Date: Thu, 22 Dec 2005 23:43:24 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] pci device ensure sysdata initialised
References: <20051220151609.565160d9.akpm@osdl.org> <20051222210628.GA16797@shadowen.org> <20051222231843.GB1943@kroah.com>
In-Reply-To: <20051222231843.GB1943@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Yeah, but this patch is just papering over that fact :(
> 
> In fact, you will not put these devices on the proper node with this
> patch, right?  So I don't think it is what you want.

If there is ACPI information for the machine I believe it will put them
in the correct nodes; otherwise it behaves as we did in -mm1, in that
they are not correctly located.  It does however prevent a boot panic
introduced by the pci domain patches.  Something similar needs to be
done here, or those patches dropped?

-apw

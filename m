Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUEPSWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUEPSWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUEPSWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:22:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:28846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264774AbUEPSWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:22:40 -0400
Date: Sun, 16 May 2004 11:22:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Brownell <david-b@pacbell.net>
cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
In-Reply-To: <40A7AF6D.6060304@pacbell.net>
Message-ID: <Pine.LNX.4.58.0405161120420.25502@ppc970.osdl.org>
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de>
 <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org> <40A7AA0B.5000200@pacbell.net>
 <Pine.LNX.4.58.0405161101160.25502@ppc970.osdl.org> <40A7AF6D.6060304@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, David Brownell wrote:
> 
> More like this then?  I'm not sure whether you'd prefer
> to apply that logic to the "struct pm_info" innards too.
> That file has multiple CONFIG_PM sections, too.

I was thinking just putting it in the existing wrapper sections.

We already have wrappers for pm_register, pm_unregister, 
pm_unregister_all, pm_send, pm_send_all, etc etc, and this would seem to 
be just one more case like that.

The alternative is to just always have "power_state" in the "dev_pm_info", 
especially as some versions of gcc have had bugs with empty structures 
anyway.

		Linus

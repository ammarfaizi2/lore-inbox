Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUDVTLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUDVTLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUDVTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:11:15 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:24845 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264641AbUDVTLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:11:13 -0400
Message-ID: <40881973.4020802@techsource.com>
Date: Thu, 22 Apr 2004 15:13:55 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: James Lamanna <jamesl@appliedminds.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New Radeonfb (2.6.5) driver does not play nice with X (4.3.0)
References: <4087EB5A.7040404@appliedminds.com> <408813B0.6000806@appliedminds.com>
In-Reply-To: <408813B0.6000806@appliedminds.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Lamanna wrote:
> Timothy Miller wrote:
>  > Are you using ATI's proprietary drivers? I have also experienced this
>  > sort of system hang when using their drivers. When I would exit the X
>  > server, I would get a screen full of vertical lines and the system
>  > would be completely dead (could not ping).
> 
>  > The short-term solutions are either to use the XFree's native drivers
>  > or to use vesafb for the console. The long term solution is for ATI to
>  > fix their drivers.
> 
> Well I did try with Driver "vga" (I had been using the ATI proprietary
> ones), and it still exhibited the same behavior.
>     

Someone told me that they found the ATI driver to get along fine with 
the VESA framebuffer driver, but I never tried it.  Since I have a 9000, 
enough of its features are supported by Mesa that I don't care, so I 
switched back.

Also, I have used ATI's drivers with Red Hat 9, and since Red Hat always 
just uses the VGA text console, it was never a problem.

Have you tried the plain 80x25 CGA/EGA/VGA character mode with the ATI 
drivers?  Don't use a graphical console driver at all and see what happens.

ATI won't help you if you contact them, but there may be some value in 
you contacting them with a report of the problem.  I did that.  If they 
get enough complaints, maybe they'll deal with it.

I suspect there is a conflict between X and radeonfb both trying to 
access the drawing engine at the same time.


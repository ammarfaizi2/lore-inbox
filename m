Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUJRVHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUJRVHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUJRVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:07:04 -0400
Received: from [69.4.201.55] ([69.4.201.55]:26768 "EHLO bitworks.com")
	by vger.kernel.org with ESMTP id S267378AbUJRVE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:04:57 -0400
Message-ID: <41742FF2.9090409@bitworks.com>
Date: Mon, 18 Oct 2004 16:04:50 -0500
From: Richard Smith <rsmith@bitworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: KendallB@scitechsoft.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
References: <4173B865.26539.117B09BD@localhost> <4173C981.13925.11BDE111@localhost>
In-Reply-To: <4173C981.13925.11BDE111@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> Richard Smith <rsmith@bitworks.com> wrote:
> 
> Good, so my assumption was incorrect which I am happy about. Since it 
> makes the work we did more useful ;-)
> 
> Anyway in your case do you need diagnostic messages just from the kernel 
> or from the firmware as well?

Firmware messages are the most critical since none of the app code is 
running yet and can't self-heal or cry for help.

Some units boot off of a compact flash.  Try as we might to make these 
babies robust they do fail.  So in that case the boot message from the 
firmware needs to be displayed.  In other cases the system net boots 
which increases the firmware error message level by about a factor of 10.

 > To get it in the firmware the video boot
 > code would need to be ported there (U-Boot has a version of it already,
 > but it is the only firmware I am aware of that supports this).

LinuxBIOS has some suport for this.  Not by emulation though.  It uses 
the bios from the BOCHS project as a payload.  Some glue drops the 
system back into real mode and runs the BOCHS bios which scans the 
legacy regions for ROM expansion modules.  So as long as I copy my video 
bios up int 0x0C0000 prior to this I get video.  Otherwise I have to 
wait until X comes up and soft-boots the display device.

-- 
Richard A. Smith



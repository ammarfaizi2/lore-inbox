Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTDNNpR (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTDNNpR (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:45:17 -0400
Received: from main.gmane.org ([80.91.224.249]:28328 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263303AbTDNNpO (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 09:45:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: Early boot oops with 2.5.67-bk(current) on a dual Athlon-MP 
  [Asus A7M266-D] machine
Date: Mon, 14 Apr 2003 09:50:33 -0400
Message-ID: <3E9ABCA9.8000802@myrealbox.com>
References: <3E99B9B4.8000304@myrealbox.com> <20030413165259.36fb0f97.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
Cc: Dave Jones <davej@codemonkey.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nicholas Wourms <nwourms@myrealbox.com> wrote:
> 
>>Hi,
>>
>>Attached is the oops (which results in a panic) when I 
>>attempt to boot the lastest bk current on my machine.
> 
> 
> The MCE code is using the workqueue infrastructure waaaaaaay earlier than it
> is allowed to.  It looks like the timer went off before the workqueue
> initialisation had been run.
> 
> This should fix it.
> 

Andrew,

Thanks for the patch.  No oops this time around, but now it 
freezes at the exact same point in the boot process.  My 
keyboard (usb) stops responding entirely, thus eliminating 
any use of the Magic SysRq key.  Same config as before, with 
your patch applied.

Cheers,
Nicholas



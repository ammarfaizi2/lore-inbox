Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUCDQhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCDQhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:37:55 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:50832 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262007AbUCDQhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:37:53 -0500
Message-ID: <40475B4E.1040902@blue-labs.org>
Date: Thu, 04 Mar 2004 11:37:34 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Joshua M. Schmidlkofer" <menion@asylumwear.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs b0rks in 2.6.2, 2.6.3
References: <1078379594.10353.20.camel@menion.home>
In-Reply-To: <1078379594.10353.20.camel@menion.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you provide any more details?  I have been using hotplug with USB 
devices daily on each of 2.6.2 through 2.6.4-rc1 without any freezes.  
The only problem I've noticed is my non-hotplug issue with USB on my 
notebook, using my wireless mouse.  After a cycle of plug/unplug/plug 
etc, the kernel starts spewing hundreds of messages a second about uhci 
issues and makes the machine very slow.  Doesn't fix until I remove the 
uhci module.  Has nothing to do with devfs or hotplug however.  Both of 
those work perfectly [for me] on four different machines.

Joshua M. Schmidlkofer wrote:

>This report is in the interest of posterity, and giving people with
>similar bugs a search result.  I don't need a fix because udev works
>100%.  However, I was unable to make devfs work at all in 2.6.2, and
>2.6.3.  I tried a lot of things, and it seemed to be locking when
>creating tty's after hotplug events.  In any case, especially usb the
>hotplug stuff seemed to trigger process freezes.  The init process would
>suddenly stop.  I SysRq worked fine, but as I was in a hurry, I did not
>try to do more troubleshooting.  I was never able to fully boot into a
>2.6.2 or 2.6.3 kernel on my box with devfs enabled.
>
>I recovered, and removed devfs, converted my gentoo install to udev, and
>have had no trouble since.
>
>thanks,
>  joshua
>
>[and thanks greg k-h et al. for making udev!!]
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUGYXfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUGYXfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 19:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUGYXfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 19:35:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:59111 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264561AbUGYXfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 19:35:42 -0400
Date: Sun, 25 Jul 2004 15:00:26 -0400
From: Greg KH <greg@kroah.com>
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Message-ID: <20040725190026.GA30535@kroah.com>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 02:47:39PM -0500, Doug Maxey wrote:
> 
> Howdy!
> 
>   This note went out originally to a semi-internal list, but after
>   several comments, posting it here...

Unfortunatly, it seems you didn't listen to those comments :(

>   What I would like is input on the general strategy that should be
>   taken to modify the controller/adapter and device stack to:
> 
>   1) be first class modules, where all controllers/adapters are
>      capable of being loaded and unloaded.  This is directed mostly at
>      IDE/Southbridge controller/adapter devices.
> 
>   2) extend that support to all child devices; disk, optical,
>      and tape.
> 
>   3) be part of mainline.

Great, that all sounds wonderful.

>   The items I perceive at the top of the issue list are:
> 
>   - The primary platforms for IDE/ATA devices are x86 based, and
>     certainly do not care about having this capability.
> 
>   - Assuming the capability is added, what rework would be acceptable
>     for block devices?

Enough to make it work :)

>   - Where should this capability go?  Fork a subset of IDE
>     controllers, and put them under the arch specific dir?
>     Or include all devices?

Not in a arch specific dir please.  You all do that too much as it is...

>   - should we work to the goal of having the capability for all
>     platforms, and all IDE devices?

Yes.

thanks,

greg k-h

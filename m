Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUAGVYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUAGVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:24:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22458 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266291AbUAGVYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:24:51 -0500
Message-ID: <3FFC790A.3060206@pobox.com>
Date: Wed, 07 Jan 2004 16:24:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it> <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com> <3FFC7469.3050700@sun.com>
In-Reply-To: <3FFC7469.3050700@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> To put it into perspective, the I'm calling for the following major 
> changes:
[...]
> 2) move the loop that used to spin around and ask kernelspace if there 
> was anything to expire into the VFS as well, where it won't be killed.
[...]
> (1) and (2) shouldn't be hard at all to do considering David Howells has 
> done the majority of this already. (3) is needed in order to manage 
> direct mounts properly for when they are 'covered'.  Admittedly, (4) 
> comes off as an ugly hack.
> 
> Also, (2) was the only 'active' task the automount daemon was doing. 
> Everything else it did can be rewritten in the form of a usermode helper 
> that runs only when it is needed.  This simplifies the userspace code a 
> lot.

Just going by your own explanation here, #2 should not be in the kernel.

If we moving daemons into the kernel just because they won't be killed, 
we'll have Oracle in-kernel before you know it.  Completely spurious reason.

	Jeff




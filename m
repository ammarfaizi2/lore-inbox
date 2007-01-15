Return-Path: <linux-kernel-owner+w=401wt.eu-S1751316AbXAORgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXAORgO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbXAORgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:36:14 -0500
Received: from [195.171.73.133] ([195.171.73.133]:34106 "EHLO
	pelagius.h-e-r-e-s-y.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751275AbXAORgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:36:14 -0500
Message-ID: <45ABBB8B.6000505@walrond.org>
Date: Mon, 15 Jan 2007 17:36:11 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Initramfs and /sbin/hotplug fun
References: <45AB8CB9.2000209@walrond.org> <20070115170412.GA26414@aepfle.de>
In-Reply-To: <20070115170412.GA26414@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> On Mon, Jan 15, Andrew Walrond wrote:
> 
>> To solve this, I deleted /sbin/hotplug from the initramfs archive and 
>> modified /init to reinstate it once it gets control. This works fine, 
>> but seems inelegant. Is there a better solution? Should sbin/hotplug be 
>> called at all before the kernel has passed control to /init?
> 
> Yes, it should be called.

Ok

> /sbin/hotplug and /init are two very different and unrelated things.

Well, of course. But looking at the thread provided by Jan, it seems the 
kernel might not be in any fit state to service the (userspace) hotplug 
infrastructure when it makes the calls (Ie can't create pipes yet).

The kernel wouldn't call /init (or /sbin/init) before it was fully ready 
to handle userspace processes, so why should it feel able to call the 
hotplug userspace?

Andrew Walrond


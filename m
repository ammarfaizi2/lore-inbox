Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWEBPat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWEBPat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWEBPat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:30:49 -0400
Received: from server6.greatnet.de ([83.133.96.26]:25507 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964888AbWEBPas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:30:48 -0400
Message-ID: <44577C75.8040202@nachtwindheim.de>
Date: Tue, 02 May 2006 17:36:21 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henne <henne@nachtwindheim.de>
Cc: arjan@infradead.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
       greg@kroah.org, greg@kroah.org
Subject: Re: [ALSA] add __devinitdata to all pci_device_id
References: <445673F0.4020607@nachtwindheim.de>
In-Reply-To: <445673F0.4020607@nachtwindheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henne wrote:
> On Mon, May 01, 2006 at 06:49:24PM +0200, Arjan van de Ven wrote:
> 
>  > are you really really sure you want to do this?
>  > These structures are exported via sysfs for example, I would think this
>  > is quite the wrong thing to make go away silently...


I tested that on my system.

make oldconfig
<comment out CONFIG_HOTPLUG>
<install and booting that kernel>
<reading vendor device, etc. of built-in devices in sysfs>
<adding new ID's via new_id>
no errors, no crash
But that mustn't mean something.
I'll take a look at the pci-driver, but some who is more familiar with that should take a look, too.

Greets,
Henne

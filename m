Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWEBQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWEBQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWEBQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:45:58 -0400
Received: from fmr17.intel.com ([134.134.136.16]:54750 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964854AbWEBQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:45:57 -0400
Message-ID: <44578C92.1070403@linux.intel.com>
Date: Tue, 02 May 2006 18:45:06 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace
 (Xorg) to enable devices without doing foul direct access
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
In-Reply-To: <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 4/29/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
>> This patch adds an "enable" sysfs attribute to each PCI device. When 
>> read it
>> shows the "enabled-ness" of the device, but you can write a "0" into 
>> it to
>> disable a device, and a "1" to enable it.
> 
> What is the rationale for this?

you snipped that out of the email ;)

> Doing this encourages people to write
> device drivers in user space that probably should be a kernel driver.

not really, there's not a lot you can do. What you CAN do is read roms and stuff like that;
the vbetool and X need that for example

> What are you going to do if two competing apps want to set it to two
> different states?

then you're root and you just shot yourself in the proverbial foot.


> An alternate way to fix this problem is to write a device driver that
> attaches to hardware with PCI class VGA.

and then that sucks too because in linux only 1 driver can bind to a device,
AND you're limited to only vga devices.

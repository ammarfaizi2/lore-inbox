Return-Path: <linux-kernel-owner+w=401wt.eu-S1750842AbXATXrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXATXrY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXATXrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:47:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:40458 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXATXrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:47:23 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eB/L3fyyzhLvme4Dyaw+3IIjdxbWoHTkTUbMD+NCcRtnpBWHRVuhl04RRBXIo8wvx24mM93teLdS7GuvSRaFcWpNAcfzzSqV0iAkEz1YUMsW0lCcHc8CayOAMNu8meqhk5AVM5sqhHo51DPYnNEJPzIUAMN+vBPNmFTBRN+XXZY=
Message-ID: <45B2AA03.4070405@gmail.com>
Date: Sun, 21 Jan 2007 02:47:15 +0300
From: Ivan Ukhov <uvsoft@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: UVSoft@gmail.com
Subject: Re: How to use an usb interface than is claimed by HID?
References: <45B265E0.5020605@gmail.com> <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> On Sat, 20 Jan 2007, Ivan Ukhov wrote:
>
>   
>> I'm writing a driver for an USB device that has one configuration with 
>> several interfacies and one of them is a HID interface. So when I check 
>> this interface whether it's claimed (usb_interface_claimed), I find out 
>> that it is, and it's claimed by the HID driver. So here is the question: 
>> how can I ask the HID driver to unclaim this very interface for me so 
>> that I can use it? The HID driver is needed for some other devices, so I 
>> can't just rmmod it.
>>     
>
> Hi Ivan,
>
> if I understand correctly what you need, wouldn't setting the 
> HID_QUIRK_IGNORE for a given tuple of idVendor and idProduct be enough? 
> (see hid_blacklist[] in drivers/usb/input/hid-core.c).
>
>   
No, it won't do. Imagine that I'm not able to modify the kernel with its 
drivers. It should work with usual kernel and HID driver. So I want my 
driver to ask the HID driver to free the interfaces or don't claim them 
at all. Mb there's an example of such a driver?.. obviously there are a 
lot of HID devices and mb a vendor one of them doesn't want to use HID 
driver for one of its interfaces to provide some additional features or 
something, so he should make the kernel use his driver instead of HID...

Does it make any sense?)

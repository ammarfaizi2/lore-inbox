Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVBOEHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVBOEHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 23:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVBOEHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 23:07:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:44989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261617AbVBOEHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 23:07:03 -0500
Message-ID: <42117305.10703@osdl.org>
Date: Mon, 14 Feb 2005 19:56:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sergio@sergiomb.no-ip.org
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and	give	dev=/dev/hdX
 as device
References: <1108426832.5015.4.camel@bastov>	 <1108434128.5491.8.camel@bastov>  <42115DA2.6070500@osdl.org> <1108439881.5308.12.camel@bastov>
In-Reply-To: <1108439881.5308.12.camel@bastov>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> Hi, don't feel much better but thanks a lot!
> 
> in conclusion ? 
> 1- hdc=ide-scsi, now should be hdc=ide-cd for general cd-writer, because
> cdrecorder don't need scsi emulation anymore.

At least partially correct:  don't use "hdc=ide-scsi".
However, I don't use "hdc=ide-cd" and I can burn CDs,
so that's not needed AFAIK.

> 2- as hdc already is ide-cd by default, therefore is not necessary to
> write it and what should be made is erase the line hdc=ide-scsi.
> 
> Correct ?

Ah, yes, we seem to agree on that.

HTH.
~Randy

> On Mon, 2005-02-14 at 18:25 -0800, Randy.Dunlap wrote:
> 
>>Sergio Monteiro Basto wrote:
>>
>>>"Use ide-cd and give dev=/dev/hdX as device" 
>>>cracks me up , Can someone translate this to English ?
>>
>>I'll try.
>>It means:  don't use the ide-scsi driver.  Support for it is
>>lagging (not well-maintained) because it's really not needed for
>>burning CDs.  Just use the ide-cd driver (module) and
>>specify the CD burner device as /dev/hdX.
>>
>>Example with cdrecord:
>>deprecated:
>>cdrecord -dev=1,0,0 -data backup.iso
>>modern :)
>>cdrecord -dev=/dev/hdc -data backup.iso
>>
>>Do you know how to _not_ use ide-scsi?  Don't load the module
>>if you have it built as a module, or don't build it into the
>>kernel boot image.  Mostly don't try to open /dev/sdX, just use
>>/dev/hdX instead.
>>
>>Hope you feel better soon.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVCYCPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVCYCPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCYCPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 21:15:51 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8034 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261179AbVCYCPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 21:15:41 -0500
Date: Thu, 24 Mar 2005 20:15:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: How's the nforce4 support in Linux?
In-reply-to: <3LwFC-4Ko-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4243743D.8070404@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3LwFC-4Ko-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asfand Yar Qazi wrote:
> NForce4 Ultra is brilliant - in many ways.  Except it requires binary 
> drivers, which I really don't want to use.  And apparently, the hardware 
> firewall seems to restrict bandwidth a bit.  And even when its off, 
> external chips that end up being faster (http://tinyurl.com/4zssp)
> 
> So, I'm wondering, are my assumptions correct?  Do I have to use binary 
> drivers to make absolutely full use of the Nforce4 chipset?  Or is there 
> sufficient support for me to make use of the features on it without 
> using binary drivers?
> 
> Sorry for asking something that may have been asked before, but I've 
> tried searching several times through the mailing list and on a search 
> engine, but have had little luck.
> 
> Thanks,
>     Asfand Yar

There is no need to use any binary drivers on the nForce4 - the only 
ones even available are for the network and audio. The network works 
fine with the forcedeth driver included in the kernel - I don't know 
about the audio, I'm not using the onboard sound.

Some wrinkles with Linux support are that you may need to update the X 
server (ex: X.org) as there are some bugs with PCI Express video on 
x86_64 that were fixed somewhat recently - as well there was a bug with 
USB port detection that cropped up in kernel 2.6.10 and I believe is 
fixed in 2.6.11.

The nForce4 chipset supports NCQ on the SATA interface, however this is 
not supported in Linux yet. It seems like the SATA controller has some 
similarity or is based on the ADMA architecture (the Windows driver is 
called "NVIDIA nForce4 ADMA Controller", so using it with the ADMA 
driver might be doable at some point, though I haven't heard of any 
hardware specs being released..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


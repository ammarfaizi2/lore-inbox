Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270616AbUJUFOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270616AbUJUFOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbUJUFFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:05:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:29570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270513AbUJUE6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:58:36 -0400
Message-ID: <417740FE.7030805@osdl.org>
Date: Wed, 20 Oct 2004 21:54:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: bevand_m@epita.fr, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: NMI watchdog detected lockup
References: <4172F91D.8090109@osdl.org>	<ckv123$pcs$1@sea.gmane.org>	<4173F9A7.2090504@osdl.org>	<20041018200017.0098710d.ak@suse.de>	<41740430.30604@osdl.org> <20041018201654.58905384.ak@suse.de>
In-Reply-To: <20041018201654.58905384.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, 18 Oct 2004 10:58:08 -0700
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> 
>>>Something on your system creates bogus NMI interrupts. What chipset
>>>are you using exactly?
>>>
>>>Sometimes chipsets can be programmed to raise NMIs when an PCI bus
>>>error occurs. 
>>>
>>>21 is the normal state (PIT timer running, but no errors logged) 
>>>
>>>If you have an AMD 8131 it could be in theory erratum 54, but then
>>>normally one of the error bits in reason should be set.
>>
>>Yes, it's an AMD-8111 / 8131 / 8151 / K8-northbridge machine.
> 
> 
> It's probably one of your IO cards. I would remove them one by one
> or possibly switch them to different slots (PCI vs PCI-X) 
> 
> -Andi

Thanks, Andi.

I removed the Adapter SCSI PCI card and switched to using
the onboard Adaptec controller, and now I'm seeing no problems,
so the AIC7xyz (or 79yz) card or driver doesn't seem to like
PCI-X or something here.

-- 
~Randy

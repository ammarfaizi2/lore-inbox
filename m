Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWCaUDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWCaUDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWCaUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:03:52 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:6321 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932265AbWCaUDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:03:51 -0500
Message-ID: <442D8B25.7070308@mvista.com>
Date: Fri, 31 Mar 2006 13:03:49 -0700
From: Dave Jiang <djiang@mvista.com>
Organization: MontaVista Software, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: gtm.kramer@inter.nl.net
Cc: Dave Peterson <dsp@llnl.gov>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: Non-Fatal Error PCI Express messages
References: <1143793550.3331.4.camel@paragon.slim>	 <200603311022.56896.dsp@llnl.gov> <1143832684.3328.15.camel@paragon.slim>
In-Reply-To: <1143832684.3328.15.camel@paragon.slim>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> On Fri, 2006-03-31 at 10:22 -0800, Dave Peterson wrote:
>> On Friday 31 March 2006 00:25, Jurgen Kramer wrote:
>>> With 2.6.16 (from FC5s 2.6.16-1.2080_FC5smp) I am getting a lot of
>>>
>>> Mar 31 09:35:16 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
>>> Mar 31 09:35:39 paragon kernel: Non-Fatal Error PCI Express B
>>>
>>> messages which presumably come from
>>>
>>> Mar 31 09:17:15 paragon kernel: MC: drivers/edac/edac_mc.c version
>>> edac_mc  Ver: 2.0.0 Mar 28 2006
>>> Mar 31 09:17:15 paragon kernel: EDAC MC0: Giving out device to
>>> "e752x_edac" E7525: PCI 0000:00:00.0
>>>
>>> Is there really something broken here of just a noisy driver?
>>>
>>> BTW this is on a Asus NCT-D mobo with Intel E7525 chipset.
>>>
>>> Jurgen
>> Hi Jurgen,
>>
>> I haven't seen this particular error before, and I can't say for sure
>> whether it's a genuine problem that should be dealt with or just a
>> minor annoyance that can be safely ignored.  EDAC is a relatively new
>> piece of code, and still very much a work in progress.  If this is in
>> fact a benign type of error, EDAC should provide a mechanism by which
>> a sysadmin can silence it.  This is an area of future work.
>>
>> I'm forwarding your message to the bluesmoke mailing list just in
>> case anyone who reads that list has seen instances of this error in
>> the past and can provide more info on it.
>>
>> Dave
> 
> Hi Dave,
> 
> So far the system is running just fine. For reference, so far I found 92
> "Non-Fatal Error PCI Express B" messages since the system was booted 8
> hours ago.
> 
> BTW Dave Jones reported similar problems on the LKML: 
>  http://lkml.org/lkml/2006/1/26/381
> 
> Cheers,
> 
> Jurgen
> 

Do you have the sysbus message patch in the e752x driver? I've seen this before 
  on certain Intel ATCA boards, but it's actually the system bus complaining 
and not the PCIe but the code is referencing the wrong print out messages. If 
you do then it's probably PCIe.

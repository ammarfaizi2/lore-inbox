Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030698AbWFOQVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030698AbWFOQVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030789AbWFOQVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:21:34 -0400
Received: from gw.goop.org ([64.81.55.164]:738 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030698AbWFOQVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:21:34 -0400
Message-ID: <449188FF.7030700@goop.org>
Date: Thu, 15 Jun 2006 09:21:19 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: George Nychis <gnychis@cmu.edu>
CC: lkml <linux-kernel@vger.kernel.org>,
       Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: cdrom support with thinkpad x6 ultrabay
References: <4490E776.7080000@cmu.edu> <4490F4BC.1040300@goop.org> <44910B54.8000408@cmu.edu> <44910E2A.5090205@goop.org> <44917B30.9010904@cmu.edu>
In-Reply-To: <44917B30.9010904@cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis wrote:
> I applied the acpi-dock patch that I specified, and that patch only, and
> i'm getting errors building:
>
> drivers/acpi/dock.c: In function 'dock_notify':
> drivers/acpi/dock.c:543: error: 'KOBJ_DOCK' undeclared (first use in
> this function)
> drivers/acpi/dock.c:543: error: (Each undeclared identifier is reported
> only once
> drivers/acpi/dock.c:543: error: for each function it appears in.)
> drivers/acpi/dock.c:562: error: 'KOBJ_UNDOCK' undeclared (first use in
> this function)
>
> Is there something else I need to apply that I am missing?
>   
Kristen?

    J
> Thanks!
> George
>
>
> Jeremy Fitzhardinge wrote:
>   
>> George Nychis wrote:
>>     
>>> it successfully is applied, and i notice that CONFIG_ACPI_DOCK needs to
>>> be set, so I did a "make oldconfig" after applying the patch, expecting
>>> it to ask me whether or not i wanted to support it... it didn't.  So
>>> then I manually added "CONFIG_ACPI_DOCK=y" to the .config and built the
>>> kernel, but dock.o is never built... what else do i need to do?
>>>   
>>>       
>> Make sure you disable the (obsolete?) ACPI_IBM_DOCK stuff.
>>
>>     
>>> If i can't get hot swappable support yet, I might as well get what is
>>> supported for now so I can atleast use it sometimes :)
>>>
>>> Maybe this cry for help will spark someone to finish off the work on hot
>>> swapping the optical drive.
>>>   
>>>       
>> Yeah, I'm hoping all the work on power management in libata will make
>> things "just work" soon, but I think there's more to it.  When you press
>> the dock eject button, it really needs to go out to acpid, activate a
>> script to unmount any filesystems mounted off the device, and then poke
>> the ata layer to remove the device, before OKing the dock eject so the
>> hardware's "don't do that" light goes out.
>>
>> But in the meantime I'm having enough trouble getting plain old
>> suspend/resume reliable.
>>
>>    J
>>
>>     


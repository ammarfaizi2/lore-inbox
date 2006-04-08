Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWDHQyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWDHQyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWDHQyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:54:04 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:12199 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965025AbWDHQyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:54:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NTHiNTjZMOOVV7ENPJAzUR+TI2Q0zqZmPHuWEX53Bq+clCW1BdjZJv5JZzmOK9HS4pXO4an6wH+i46TwhU8R6NC3mLvM5boXTbkrghXXC+v6VRl+EakzXw0D1gTPmN2ZZCO/8JVUvfymaicYCcBv8zApA1soiEef4AoCcTtFy+Y=
Message-ID: <4437EAA3.7000408@gmail.com>
Date: Sat, 08 Apr 2006 18:53:55 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060407)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "Kernel," <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [BUG] 2.6.16.2 (like olders) fails to suspend audio device
References: <4437BB29.8050502@gmail.com> <1144513623.22490.150.camel@mindpipe>
In-Reply-To: <1144513623.22490.150.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell ha scritto:
> It would help if you cc'ed the right list (added)
>
> On Sat, 2006-04-08 at 15:31 +0200, Patrizio Bassi wrote:
>   
>> I've already posted same bug some weeks ago.
>>
>> this is just a reminder and to confirm bug is still there.
>>
>> 00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
>>
>> Alsa driver: 1370
>>
>> 1) if builtin in kernel, on resume it doesn't work any more.
>> 2) if built as module on resume it works with no need to remove/readd 
>> module.
>>
>> in both situations dmesg shows:
>>
>> pnp: Failed to activate device 00:0b.
>>
>>
>> Stopping tasks: ===========================================|
>> Shrinking memory... done (39214 pages freed)
>> pnp: Device 00:0c disabled.
>> pnp: Device 00:08 disabled.
>> swsusp: Need to copy 13752 pages
>> ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) 
>> -> IRQ 9
>> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) 
>> -> IRQ 9
>> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) 
>> -> IRQ 9
>> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) 
>> -> IRQ 5
>> ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKD] -> GSI 9 (level, low) 
>> -> IRQ 9
>> ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKA] -> GSI 11 (level, 
>> low) -> IRQ 11
>> usb usb1: root hub lost power or was reset
>> ehci_hcd 0000:00:0a.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
>> ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, 
>> low) -> IRQ 10
>> pnp: Device 00:08 activated.
>> pnp: Failed to activate device 00:0b.
>> pnp: Device 00:0c activated.
>> Restarting tasks... done
>> agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
>> agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
>> agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
>>
>> lspci
>> 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
>> bridge (rev 03)
>> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
>> bridge (rev 03)
>> 00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
>> 00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
>> 00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
>> 00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
>> 00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
>> (rev 74)
>> 00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
>> Controller (rev 50)
>> 00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
>> Controller (rev 50)
>> 00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
>> 00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
>> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP
>>
>>
>> dmesg says 00:08 and 00:0c are activated..but i've no idea which devices 
>> they are, lspci -vv shows nothing about that.
>>
>> Ready to give more infos and test patches.
>>
>> Patrizio Bassi
>>
>>     
>   
you're right, sorry, but, having the strange devices in dmesg let me 
think that's a problem
in suspend too.


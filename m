Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRBZQsw>; Mon, 26 Feb 2001 11:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130332AbRBZQsn>; Mon, 26 Feb 2001 11:48:43 -0500
Received: from smtp8.dti.ne.jp ([202.216.228.43]:40320 "EHLO smtp8.dti.ne.jp")
	by vger.kernel.org with ESMTP id <S130329AbRBZQs1>;
	Mon, 26 Feb 2001 11:48:27 -0500
Message-Id: <200102261648.BAA09972@smtp8.dti.ne.jp>
Date: Tue, 27 Feb 2001 01:48:26 +0900
From: Junichi Morita <jun1m@mars.dti.ne.jp>
To: Matthias Bruestle <m@mbsks.franken.de>
Cc: linux-kernel@vger.kernel.org, tridge@linuxcare.com
Subject: Re: Power management on Sony C1Vx
In-Reply-To: <20010225205521.C3253@mbsks.franken.de>
In-Reply-To: <20010225205521.C3253@mbsks.franken.de>
X-Mailer: Sylpheed version 0.4.4 (GTK+ 1.2.8; Linux 2.4.2; i586)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a C1VJ.

> Note as stated in the FAQ: I am not subscribed, so please CC also to me,
> when answering. (Or else my spies have to do this. :) )
> 
> Mahlzeit
> 
> 
> I have been told, that I might get help here. I have a Sony VAIO C1Vx.
> (In my case x=E.) My problem is the power management, i.e. standby and
> suspend. I was not able to get it working (properly). Is here someone
> who got it working or knows, that it will not work?
> 
> My tries so far:
> 
> 2.4.2 with APM:
> 
> - Fn+Fxx does nothing.
I think ... This <Fn+Fxx> keys controled by SPIC(Sony Programmable I/O Control Device).
Download a picturebook application from
 http://samba.org/picturebook/
and make it.
and check with this command...
 # capture -j
then press <Fn+Fxx> keys. May be you can see the press event...
Here is a event data...
 <Fn+ESC>  : event 0x10 0x29  &  event 0x10 0x28
 <Fn+F1>   : event 0x11    ------ same -----
 <Fn+F2>   :       0x12
    :                :    <F3> -> <F11> : 0x13 -> 0x1b
 <Fn+F12>  :       0x1c
 <Fn+"1">  :       0x21
 <Fn+"2">  :       0x22
 <Fn+"B">  :       0x35
 <Fn+"F">  :       0x33
 <Fn+"E">  :       0x32
 <Fn+"S">  :       0x34
 <Fn+"D">  :       0x31

> - standby makes the display black, but switches not the backlights off.
>   The only way to go back to normal is by switching to a text console
>   and then back to X.
Recompile the your Kernel with "Enable console blanking using APM" option.
then the backlights off.(only text console)
I checked Kernel 2.2.17,2.2.18 & 2.4.2

> - suspend is done properly, but to only way to get back to normal is
>   by switching the computer off and then boot again.
> 
> 2.2.16 with APM:
> 
> - Same as above.
Same...
but. My case is .... Wake up the CPU-FAN & IDE-LED ??? 

> 2.4.2 with ACPI:
> 
> - I have compiled 2.4.2 with ACPI and without APM. acpid is started.
> - Fn-Fxx does hang the display and probably computer until a few seconds
>   after pressing a key or mouse button.
> - Don't know no other way of going into suspend or standby with ACPI.
> 
> 2.4.2-ac3 with ACPI:
> 
> - Same as above, but Fn-Fxx does nothing.
> 
> So do I wasting here my time or is it possible to get standby/suspend
> working with the C1Vx? Has somebody got it working with APM or ACPI?
> Some pointers or even a detailed description?
> 
My VAIO could(can) go into suspend mode....but never wakeup.
as same as APM case.

> 
> Thanks all
> 
> endergone Zwiebeltuete
> 
> PS: I have installed Red Hat 7.0 (aka Little Red Ridinghood).
> 
> -- 
> live free or die
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
addition....
You can use the internal USB-Memory-Stick device with Kernel 2.2.18 and usb-storage module. and the sound module is ymfpci.
take care about ymfpci module... because, some time I get a NOISE!!!
in this case just shutdown(not reboot!).

Thanks
--
Junichi Morita
jun1m@mars.dit.ne.jp

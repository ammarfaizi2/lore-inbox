Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270121AbRIBWjm>; Sun, 2 Sep 2001 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270131AbRIBWjc>; Sun, 2 Sep 2001 18:39:32 -0400
Received: from sun.he.net ([216.218.153.2]:28937 "EHLO sun.he.net")
	by vger.kernel.org with ESMTP id <S270121AbRIBWjR>;
	Sun, 2 Sep 2001 18:39:17 -0400
Date: Sun, 2 Sep 2001 18:38:12 -0400
From: Alan Garrison <alan@alangarrison.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
Message-ID: <20010902183812.A5591@alangarrison.com>
Reply-To: Alan Garrison <alan@alangarrison.com>
In-Reply-To: <3B9278F3.AFEF3A91@t-online.de> <Pine.LNX.4.33.0109021748090.2175-100000@TesterTop.PolyDom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109021748090.2175-100000@TesterTop.PolyDom>; from tester@videotron.ca on Sun, Sep 02, 2001 at 05:51:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 05:51:19PM -0400, Tester wrote:
> Hi,
> 
> I dont see any conflicts with ac5, and it still doesnt work... I think
> Linus's explanation of the problem is more probable... Also, I have not
> been able to reproduce the crash with ACPI recently.. It seems that if I
> have ACPI, but no APM, it does freeze... Kernel with APM or with no power
> management at all will crash under the same circumstances... But how do I
> fix that... I dont know...
> 
> show version:
> ACPI enabled kernel works fine...
> Everything else freezes with yenta...

I am in the same boat as Tester.  My laptop using kernels 2.4.8, 2.4.9, 
and a few -ac patches locks every single time when yenta_socket loads.  
Everything besides yenta_socket seems to work fine (so far).  I 
generally compile APM as a module and I am not loading it on boot, so 
there are few modules loading on a raw boot.  Perhaps I am required to 
use some sort of PNP setup with 2.4.x?  My stupid bios has absolutely 
no settings regarding pcmcia/pccard.  The only half-relevant option is 
the "PNP OS Installed?  Y/N".  Using 2.2.19pre17 (stock Debian Potato 
kernel) works generally fine with i82365/pcnet_cs loaded.

If anyone needs more h/w info or would like me to test patches I'd be 
more than happy to help.

***** 2.4.9 "lspci" output:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:03.0 CardBus bridge: Texas Instruments PCI1251B
00:03.1 CardBus bridge: Texas Instruments PCI1251B
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 0a)
00:09.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 09)
00:13.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro AGP-133 (rev dc)

> Tester
 
-- 
alan at       __  Corporate Accounts Payable, Nina speaking... Just a moment.
alangarrison  __  Corporate Accounts Payable, Nina speaking... Just a moment.
dot com       __  Corporate Accounts Payable, Nina speaking... Just a moment.
"all your apt-get are / belong to us dist-upgrade / now for great honour" -MM

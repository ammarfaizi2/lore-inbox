Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUHXVrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUHXVrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUHXVmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:42:05 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:62918 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S268370AbUHXViJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:38:09 -0400
Message-ID: <412BB4EA.50500@softhome.net>
Date: Tue, 24 Aug 2004 14:36:42 -0700
From: Brannon Klopfer <plazmcman@softhome.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Unpluging PC Card while apm -s'd
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux littleblue 2.6.8.1 #81 Wed Aug 18 17:13:39 PDT 2004 i686 unknown 
unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib 
snd_mpu401_uart snd_rawmidi snd_cs4231_lib nfsd exportfs intel_agp 
uhci_hcd serial_cs 3c574_cs ds yenta_socket pcmcia_core agpgart

-----------------------------
Hello,
    I have a Realtek-based 32-bit PC card (uses 8139too). It works 
flawlessly under normal circumstances - very fast, can unplug, etc. 
while the machine is hot. However, if I unplug when the machine is 
suspended (apm -s), upon resume, the machine locks up - capslock works, 
but that's about it. Since this card has a built-in connector (i.e., 
it's bigger than a normal PCMCIA card), I can see wanting to put it to 
sleep, then remembering that I ought to take out the card (which I _can_ 
do, so long as I plug it back in before it wakes up). A bit annoying. 
Oh, I have tried, before suspending, modprobe -r'ing the proper module 
(8139too), same thing (grrr...).

For what it's worth, this card is _not_ recognized at all by cardmgr - I 
plug it in, and then it shows up via "lspci". "cat /var/lib/pcmcia/stab" 
returns both slots as empty. I'll send my kernel config if you want. I 
assume I don't need any PCI hotplug support in the kernel, as everything 
works fine unless I suspend, remove, wake up (eve though the PCMCIA card 
shows up as a PCI device). My PCMCIA slots work fine, as I have another 
"true" PCMCIA card.

I'm sure this must be a little confusing to the poor kernel - going to 
sleep and awaking only to find your NIC is missing. Traumatic.

-Brannon Klopfer

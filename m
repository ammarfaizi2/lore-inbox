Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275744AbRI0Cc3>; Wed, 26 Sep 2001 22:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275747AbRI0CcU>; Wed, 26 Sep 2001 22:32:20 -0400
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:12672 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S275744AbRI0CcO>; Wed, 26 Sep 2001 22:32:14 -0400
Message-ID: <3BB28FC6.9090404@kjellander.com>
Date: Thu, 27 Sep 2001 04:32:38 +0200
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010925
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 crashes hard when starting X.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried 2.4.10 my machine crashed really hard upon starting the
Xserver, not even alt-sysrq-SU worked, but alt-sysrq-B did reboot the
machine. I've been trying divide and conquer to find out which kernel
that crashes my machine from 2.4.8 and 2.4.10.

2.4.8        works fine
2.4.9        works fine
2.4.10-pre8  works fine
... (will try other kernels between pre8 and final tomorrow)
2.4.10       crashes hard

I can here the monitor changing resolition just before the machine
halts, but the screen is all black so I can't see any oopsmessages.
I've tried with and without FB-console and with and without DRI
enabled.

Since alt-sysrq-S doesn't work, there is no usable message in
/var/log/messages or output from startx.

The only patch applied is the ext3 patch.

The system is a Pentium II and the graphics card a Voodoo3 3000.


# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux razor.hemmet.chalmers.se 2.4.10-pre8 #1 Thu Sep 27 02:40:55 CEST 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.23
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         binfmt_misc tuner tvaudio bttv microcode pwcx pwc
   usbmouse nfs lockd sunrpc autofs 8139too ipchains vfat fat ntfs es1371
   ac97_codec soundcore mousedev hid usb-uhci usbcore

# rpm -q XFree86
XFree86-4.0.3-5

# rpm -q gcc
gcc-2.96-85

Distribution RH 7.1.

Is it an AGPGART issue perhaps. I've tried with and without IOAPIC on UP
after reading the mail from Matthias Andree. Should I try XFree 4.1.0?

* Please CC me as I'm not on the list.

/Carl-Johan Kjellander
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`


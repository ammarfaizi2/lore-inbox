Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSANXhE>; Mon, 14 Jan 2002 18:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289297AbSANXgr>; Mon, 14 Jan 2002 18:36:47 -0500
Received: from jalon.able.es ([212.97.163.2]:59811 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289296AbSANXg1>;
	Mon, 14 Jan 2002 18:36:27 -0500
Date: Tue, 15 Jan 2002 00:42:05 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-ID: <20020115004205.A12407@werewolf.able.es>
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com> <E16QETz-0002yD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16QETz-0002yD-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on lun, ene 14, 2002 at 22:17:31 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020114 Alan Cox wrote:
>> Ok. So what do we do about it? I mean there are possibly some more people out
>> there with such a problem, or - to my prediction - there will be more in the
>> future. I see to possibilities:
>> 1) simply increase it overall. I have not the slightest idea what the drawbacks
>> are. 2) make it configurable (looks like general setup to me).
>
>Making it bigger reduces that amount of ram directly mapped by the kernel 
>which hits performance (nastily for 2.4 not so bad for 2.5)

(Sorry for joning so late to the thread...)
It is wokring fine for me, under 2.4.18-pre3 + NVidia. The difference is
that I am using version 0.7.87 (see http://giga.cps.unizar.es/~magallon/linux/2.4.18-pre3/)
I have just checked the bttv page (http://bytesex.org/bttv/) and there is
a newer version (0.7.88). What comes in .17 is 0.7.83. I have not
noticed anything relevant in changelog, but you can try...

lsmod:
werewolf:~# lsmod
Module                  Size  Used by    Tainted: P  
tuner                   8548   1  (autoclean)
tvaudio                 9312   0  (autoclean) (unused)
msp3400                14768   1  (autoclean)
bttv                   63424   0  (autoclean)
i2c-algo-bit            7244   1  (autoclean) [bttv]
videodev                4960   3  (autoclean) [bttv]
emu10k1                57728   1 
sound                  55052   0  [emu10k1]
ac97_codec              9472   0  [emu10k1]
soundcore               3524   7  [emu10k1 sound]
serial                 45792   7 
isa-pnp                28968   0  [serial]
w83781d                17792   0  (unused)
i2c-proc                6112   0  [w83781d]
i2c-isa                 1188   0  (unused)
i2c-piix4               3908   0  (unused)
i2c-core               13408   0  [tuner tvaudio msp3400 bttv i2c-algo-bit w83781d i2c-proc i2c-isa i2c-piix4]
NVdriver              821600  14 
agpgart                17024   3 
ne2k-pci                4960   1 
8390                    6608   0  [ne2k-pci]

--
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre3-beo #5 SMP Sun Jan 13 02:14:04 CET 2002 i686

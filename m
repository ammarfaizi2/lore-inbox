Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280028AbRKNCvO>; Tue, 13 Nov 2001 21:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280030AbRKNCvF>; Tue, 13 Nov 2001 21:51:05 -0500
Received: from rigel.neo.shinko.co.jp ([210.225.91.71]:3314 "EHLO
	rigel.neo.shinko.co.jp") by vger.kernel.org with ESMTP
	id <S280028AbRKNCuz>; Tue, 13 Nov 2001 21:50:55 -0500
Message-ID: <3BF1DBFF.C02A5274@neo.shinko.co.jp>
Date: Wed, 14 Nov 2001 11:50:39 +0900
From: nakai <nakai@neo.shinko.co.jp>
X-Mailer: Mozilla 4.78 [ja] (WinNT; U)
X-Accept-Language: ja,en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: badblocks fails with promise 100TX2
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I run badblocks, it failed, sometime it hanged OS.

Condition:
    runs 2 badblocks command at same time, check different drives.
    EX) badblocks /dev/hdh4; badblocks /dev/hde4
    /dev/hdh and /dev/hde is connected to promise fasttrak 66
    (with pdc20267 chip). I also tested with fasttrak 100TX2 (with
    pdc20268), and got same results.
    Duron(800)/VT133/VIA686b
    RedHat7.1(with 2.4.10 kernel)
Results:
    They report many blocks(are broken). If I kill one badblocks
    command, another badblocks command stops reporting blocks. 
    I think there is conflict when read out.
    On 2.4.2, there is no problem (but can not use fasttrak 100).
    
I know, there is some changes on ide-pci.c between 2.4.2 and 2.4.10,
and many changes on pdc202xx.c. Something go wrong?
I just want to build software RAID. But by this problem, I can
not build Software RAID with new promise 100TX2 card.

-- 
-=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
=-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
-=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
=-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
-=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-

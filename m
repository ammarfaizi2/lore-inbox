Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbTHTMxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTHTMxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:53:47 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:35484
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id S261922AbTHTMxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:53:42 -0400
X-Mailbox-Line: From galia@st-peter.stw.uni-erlangen.de  Wed Aug 20 14:53:39 2003
Message-ID: <1061384019.3f436f531a333@secure.st-peter.stw.uni-erlangen.de>
Date: Wed, 20 Aug 2003 14:53:39 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6 test3-bk7 & -mm3 : HPT374 - cable missdetection, lock-ups
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

first test run of 2.6 on Epox 8k9a3+ VIA KT400 VT8235, 
HPT374 and 4 IBM Deskstar GXP120 80Gb on each chanel as master
Mandrake-cooker gcc-3.3.1

the 3rd and the 4th chanel of the HPT374 are saying that the used cable
is 40 wires, so it forces the drives in UDMA33 which i think causes the lock-
ups several seconds after booting in runlevel 1

tried  enabling "ignore word94 validation bits", didn't change anything

any hints ?


no dmesg or logs available because of the hard lock-ups

.configs from test3-bk7 & test3-mm3
cp -a /proc/ide & /sys 
are at http://varna.demon.co.uk/~svetlio/2.6test3bk7/

svetljo

PS.

please CC me as i'm not subscribed to the list

/proc/ide/hpt366 2.4.22rc2
-------------------------
Controller: 0
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 

Controller: 1
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 


/proc/ide/hpt366 2.6 test3-bk7
----------------------------------

Controller: 0
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 

Controller: 1
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-33                          ATA-33

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 





-- 



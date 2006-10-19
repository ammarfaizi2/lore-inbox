Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946562AbWJSWJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946562AbWJSWJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946563AbWJSWJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:09:58 -0400
Received: from commie.imr-net.com ([65.182.241.242]:45037 "EHLO
	commie.imr-net.com") by vger.kernel.org with ESMTP id S1946562AbWJSWJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:09:56 -0400
Message-ID: <4537F7AA.4060709@imr-net.com>
Date: Thu, 19 Oct 2006 15:09:46 -0700
From: Joshua Schmidlkofer <joshua@imrlive.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Recurring MegaRAID SCSI Errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are getting errors from a MegaRAID device.  We have been able to 
semi-consistently reproduce this by copying large files to the network.  
This is a Dell PowerEdge 1800.

We have replaced everything in the system. 
 - 2 New RAID Cards.
 - New Memory
 - New Motherboard
 - New case.

We are currently running 2.6.17.7 - we have been upgrading slowly.  
First due to problems with the RAID that were fixed in 15 or 16, second, 
the numerous special XFS fixes that have been needed.

I have no idea why this is happening, and could really use some guidance.

Dell is fast running out of suggestions.  No errors except what the 
kernel reports are being found.

sincerely,
  joshua


02:05.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)

02:05.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
        Subsystem: Dell MegaRAID 518 DELL PERC 4/DC RAID Controller
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 185
        Memory at f80f0000 (32-bit, prefetchable) [size=64K]
        Expansion ROM at fea00000 [disabled] [size=64K]
        Capabilities: [80] Power Management version 2

[Snip]

[17333187.152000] megaraid: aborting-6172683 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: scsi cmd:6172683, do now own
[17333187.152000] megaraid: aborting-6172684 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: scsi cmd:6172684, do now own
[17333187.152000] megaraid: aborting-6172685 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172685:49[255:129], fw owner
[17333187.152000] megaraid: aborting-6172686 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172686:112[255:129], fw owner
[17333187.152000] megaraid: aborting-6172687 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172687:35[255:129], fw owner
[17333187.152000] megaraid: aborting-6172688 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172688:37[255:129], fw owner
[17333187.152000] megaraid: aborting-6172690 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172690:90[255:129], fw owner
[17333187.152000] megaraid: aborting-6172691 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172691:72[255:129], fw owner
[17333187.152000] megaraid: aborting-6172693 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172693:57[255:129], fw owner
[17333187.152000] megaraid: aborting-6172695 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172695:116[255:129], fw owner
[17333187.152000] megaraid: aborting-6172708 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172708:38[255:129], fw owner
[17333187.152000] megaraid: aborting-6172709 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172709:79[255:129], fw owner
[17333187.152000] megaraid: aborting-6172710 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172710:58[255:129], fw owner
[17333187.152000] megaraid: aborting-6172711 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172711:52[255:129], fw owner
[17333187.152000] megaraid: aborting-6172712 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172712:75[255:129], fw owner
[17333187.152000] megaraid: aborting-6172713 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172713:23[255:129], fw owner
[17333187.152000] megaraid: aborting-6172714 cmd=2a <c=2 t=1 l=0>
[17333187.152000] megaraid abort: 6172714:124[255:129], fw owner
[17333187.152000] megaraid: 15 outstanding commands. Max wait 300 sec
[17333187.152000] megaraid mbox: Wait for 15 commands to complete:300
[17333192.172000] megaraid mbox: Wait for 10 commands to complete:295
[17333197.192000] megaraid mbox: Wait for 3 commands to complete:290
[17333199.200000] megaraid mbox: reset sequence completed sucessfully
[17333237.288000] megaraid: aborting-6173089 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173089, do now own
[17333237.288000] megaraid: aborting-6173090 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173090, do now own
[17333237.288000] megaraid: aborting-6173091 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173091, do now own
[17333237.288000] megaraid: aborting-6173092 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173092, do now own
[17333237.288000] megaraid: aborting-6173093 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173093, do now own
[17333237.288000] megaraid: aborting-6173094 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173094, do now own
[17333237.288000] megaraid: aborting-6173095 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173095, do now own
[17333237.288000] megaraid: aborting-6173096 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: scsi cmd:6173096, do now own
[17333237.288000] megaraid: aborting-6173098 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173098:90[255:129], fw owner
[17333237.288000] megaraid: aborting-6173099 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173099:120[255:129], fw owner
[17333237.288000] megaraid: aborting-6173103 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173103:49[255:129], fw owner
[17333237.288000] megaraid: aborting-6173116 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173116:97[255:129], fw owner
[17333237.288000] megaraid: aborting-6173117 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173117:62[255:129], fw owner
[17333237.288000] megaraid: aborting-6173118 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173118:77[255:129], fw owner
[17333237.288000] megaraid: aborting-6173119 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173119:94[255:129], fw owner
[17333237.288000] megaraid: aborting-6173126 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173126:72[255:129], fw owner
[17333237.288000] megaraid: aborting-6173127 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173127:115[255:129], fw owner
[17333237.288000] megaraid: aborting-6173128 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173128:61[255:129], fw owner
[17333237.288000] megaraid: aborting-6173129 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173129:57[255:129], fw owner
[17333237.288000] megaraid: aborting-6173139 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173139:79[255:129], fw owner
[17333237.288000] megaraid: aborting-6173140 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173140:38[255:129], fw owner
[17333237.288000] megaraid: aborting-6173142 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173142:116[255:129], fw owner
[17333237.288000] megaraid: aborting-6173144 cmd=2a <c=2 t=1 l=0>
[17333237.288000] megaraid abort: 6173144:76[255:129], fw owner
[17333237.288000] megaraid: 15 outstanding commands. Max wait 300 sec
[17333237.288000] megaraid mbox: Wait for 15 commands to complete:300
[17333242.308000] megaraid mbox: Wait for 10 commands to complete:295
[17333247.328000] megaraid mbox: Wait for 3 commands to complete:290
[17333249.336000] megaraid mbox: reset sequence completed sucessfully
[17333310.648000] megaraid: aborting-6173544 cmd=2a <c=2 t=1 l=0>
[17333310.648000] megaraid abort: scsi cmd:6173544, do now own
[17333310.648000] megaraid: aborting-6173545 cmd=2a <c=2 t=1 l=0>
[17333310.648000] megaraid abort: scsi cmd:6173545, do now own
[17333310.648000] megaraid: aborting-6173546 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173546, do now own
[17333310.652000] megaraid: aborting-6173547 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173547, do now own
[17333310.652000] megaraid: aborting-6173563 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173563, do now own
[17333310.652000] megaraid: aborting-6173564 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173564, do now own
[17333310.652000] megaraid: aborting-6173565 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173565, do now own
[17333310.652000] megaraid: aborting-6173566 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173566, do now own
[17333310.652000] megaraid: aborting-6173567 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173567, do now own
[17333310.652000] megaraid: aborting-6173568 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173568, do now own
[17333310.652000] megaraid: aborting-6173569 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173569, do now own
[17333310.652000] megaraid: aborting-6173578 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173578, do now own
[17333310.652000] megaraid: aborting-6173579 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173579, do now own
[17333310.652000] megaraid: aborting-6173580 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173580, do now own
[17333310.652000] megaraid: aborting-6173583 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173583, do now own
[17333310.652000] megaraid: aborting-6173598 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173598, do now own
[17333310.652000] megaraid: aborting-6173599 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173599, do now own
[17333310.652000] megaraid: aborting-6173600 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173600, do now own
[17333310.652000] megaraid: aborting-6173601 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173601, do now own
[17333310.652000] megaraid: aborting-6173602 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173602, do now own
[17333310.652000] megaraid: aborting-6173603 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173603, do now own
[17333310.652000] megaraid: aborting-6173604 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173604, do now own
[17333310.652000] megaraid: aborting-6173605 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173605, do now own
[17333310.652000] megaraid: aborting-6173633 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173633, do now own
[17333310.652000] megaraid: aborting-6173638 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173638, do now own
[17333310.652000] megaraid: aborting-6173639 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173639, do now own
[17333310.652000] megaraid: aborting-6173640 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173640, do now own
[17333310.652000] megaraid: aborting-6173662 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173662, do now own
[17333310.652000] megaraid: aborting-6173663 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173663, do now own
[17333310.652000] megaraid: aborting-6173664 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173664, do now own
[17333310.652000] megaraid: aborting-6173665 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173665, do now own
[17333310.652000] megaraid: aborting-6173675 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173675, do now own
[17333310.652000] megaraid: aborting-6173677 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173677, do now own
[17333310.652000] megaraid: aborting-6173678 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173678, do now own
[17333310.652000] megaraid: aborting-6173679 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173679, do now own
[17333310.652000] megaraid: aborting-6173685 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173685, do now own
[17333310.652000] megaraid: aborting-6173686 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173686, do now own
[17333310.652000] megaraid: aborting-6173687 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173687, do now own
[17333310.652000] megaraid: aborting-6173688 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173688, do now own
[17333310.652000] megaraid: aborting-6173699 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173699, do now own
[17333310.652000] megaraid: aborting-6173700 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173700, do now own
[17333310.652000] megaraid: aborting-6173701 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: scsi cmd:6173701, do now own
[17333310.652000] megaraid: aborting-6173702 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173702:112[255:129], fw owner
[17333310.652000] megaraid: aborting-6173712 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173712:25[255:129], fw owner
[17333310.652000] megaraid: aborting-6173713 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173713:92[255:129], fw owner
[17333310.652000] megaraid: aborting-6173717 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173717:31[255:129], fw owner
[17333310.652000] megaraid: aborting-6173718 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173718:54[255:129], fw owner
[17333310.652000] megaraid: aborting-6173722 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173722:124[255:129], fw owner
[17333310.652000] megaraid: aborting-6173723 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173723:56[255:129], fw owner
[17333310.652000] megaraid: aborting-6173728 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173728:107[255:129], fw owner
[17333310.652000] megaraid: aborting-6173733 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173733:8[255:129], fw owner
[17333310.652000] megaraid: aborting-6173736 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173736:98[255:129], fw owner
[17333310.652000] megaraid: aborting-6173737 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173737:33[255:129], fw owner
[17333310.652000] megaraid: aborting-6173738 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173738:1[255:129], fw owner
[17333310.652000] megaraid: aborting-6173743 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173743:10[255:129], fw owner
[17333310.652000] megaraid: aborting-6173759 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173759:21[255:129], fw owner
[17333310.652000] megaraid: aborting-6173760 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173760:5[255:129], fw owner
[17333310.652000] megaraid: aborting-6173769 cmd=2a <c=2 t=1 l=0>
[17333310.652000] megaraid abort: 6173769:127[255:129], fw owner
[17333310.652000] megaraid: 16 outstanding commands. Max wait 300 sec
[17333310.652000] megaraid mbox: Wait for 16 commands to complete:300
[17333315.672000] megaraid mbox: Wait for 10 commands to complete:295
[17333320.692000] megaraid mbox: Wait for 2 commands to complete:290
[17333321.696000] megaraid mbox: reset sequence completed sucessfully



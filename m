Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWDBTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWDBTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWDBTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 15:55:59 -0400
Received: from smtpout.mac.com ([17.250.248.44]:19701 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932398AbWDBTz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 15:55:58 -0400
In-Reply-To: <Pine.LNX.4.44.0604021508540.2653-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0604021508540.2653-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0FE43D5B-B25D-45C7-83ED-4DE1552EC9DB@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       John Livingston <jujutama@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric D. Mudama" <edmudama@gmail.com>,
       Robert Hancock <hancockr@shaw.ca>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Sun, 2 Apr 2006 15:55:47 -0400
To: Mark Hahn <hahn@physics.mcmaster.ca>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to Mark Hahn's repeated demands that I leave his replies offlist,  
I have not included the contents of his message, however as I am  
_quite_ sure that my problem is not due to failing or misconfigured  
hardware, I am sending my own post to the LKML and a few others in  
hopes of receiving additional information that can help me debug the  
kernel's confusion.

Like I have tirelessly repeated to you before, Mark:

(1)  This same behavior occurs on both controllers regardless of  
which drive and cable combination is attached to the controller.  I  
spent several hours when I first set the system up trying every drive  
and cable permutation possible, given the 3 drives I had at the time  
and the 5 cables from 4 different manufacturers.  Each and every time  
it was the PDC controller that gave errors for its two drives until  
it reset itself, and from that point in boot on everything was fine.   
There is no possible way for it to be a cable or drive specific  
problem, I have since replaced 2 of the drives one-by-one with  
different drives as they failed due to old age, both times using a  
new drive and the shipped cable, in every case it gave the same errors.

(2)  It's extremely unlikely that the card itself is faulty; it  
exhibits identical symptoms on both drives and has ever since I  
originally purchased the card and installed 2.4.X on the system.

(3)  It's not possible that it's the power supply.  As I said before  
I checked the power supply with an oscilliscope _during_boot_.  The  
levels were correct (12V and 5V), and virtually noise-free.  The  
hardware was originally designed to reliably support the power load  
placed on it, it's a 350W power supply with the 3 drives, a low-power  
400MHz CPU, a Rage128 GPU, and 800MB or so of PC-100 RAM.

(4)  I'm not an idiot, I've administered a whole lab full of  
workstations with a wide variety of IDE hardware from the very old to  
the very new; I know what I'm doing and how to properly connect the  
cables.  It's not like it takes a genius anyways given that the host- 
side socket is blue and the drive-side one is black.  I know how a  
single drive always goes at the end of a cable.  Etc.  I've even had  
to deal with old systems with old-style Y-shaped ATA cables that had  
a drive at each end; and I know how to tell the difference between them.

(5)  The cables themselves run flat against the grounded metal of the  
case, the machine itself has little enough EMI as it is; no wireless  
chips and a low-speed CPU and bus, the wires are well away from the  
power supply.  Even if that were the case, I've rearranged the wire  
routing many times and _never_ seen a change in behavior, even  
removing the CD-ROM drive and placing a drive there had no effect.

If (as Alan Cox suggested) the problem lies with the kernel  
incorrectly detecting IDE settings from the controller or not  
noticing a buggy firmware, then I'm hoping that with some help I can  
determine where the kernel driver is getting confused and correct the  
programmed bus timings (or whatever the hell isn't working).  As my  
practical knowledge of the ATA and IDE protocols is quite limited I'm  
well out of my depth here and unable to debug without further  
assistance.

Cheers,
Kyle Moffett


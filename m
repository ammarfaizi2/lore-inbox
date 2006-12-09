Return-Path: <linux-kernel-owner+w=401wt.eu-S1759143AbWLIGGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759143AbWLIGGE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759147AbWLIGGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:06:04 -0500
Received: from web57812.mail.re3.yahoo.com ([68.142.236.90]:33317 "HELO
	web57812.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759143AbWLIGGD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:06:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WBru9MLSmO3vYXjwzXxYNQzY4Y9Qn13i2M0lD5tM6bgVrvOmZai6lzr1QPgM0wwJVOsje8PZ+XsDcj5Ykim+skNIcq/fYvqTs7OIZIKEzc30OQEY28sFDaWxP9xEJL1FIMOJAHKCEri0kl9/eS+1qZz6yfTF5pimzAMUUKgHhI8=  ;
Message-ID: <20061209060602.98025.qmail@web57812.mail.re3.yahoo.com>
Date: Fri, 8 Dec 2006 22:06:02 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems reading VCDs under various Linux distros (Fedora Core 6, openSUSE 10.2, Slackware 11 with the 2.6 kernel), and while searching Google for a solution I found that this problem has been mentioned on the LKML list too. (http://lkml.org/lkml/2006/10/29/95)

I didn't see any responses after the post linked to above, so I'd like to add that I too get this problem and that I've tried with various VCDs and players. In previous versions of these distros I could just mount the VCD and copy the *.DAT files across; but in the current versions I can't even mount! dmesg gets flooded with errors such as the below: 

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
  The failed "Read 10" packet command was: 
  "28 00 00 00 73 f2 00 00 01 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdc, sector 118728
Buffer I/O error on device hdc, logical block 29682
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
  The failed "Read 10" packet command was: 
  "28 00 00 00 73 f3 00 00 03 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdc, sector 118732
Buffer I/O error on device hdc, logical block 29683
Buffer I/O error on device hdc, logical block 29684
Buffer I/O error on device hdc, logical block 29685
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
  The failed "Read 10" packet command was: 
  "28 00 00 00 73 f2 00 00 02 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdc, sector 118728
Buffer I/O error on device hdc, logical block 29682
Buffer I/O error on device hdc, logical block 29683
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
  The failed "Read 10" packet command was: 
  "28 00 00 00 73 f2 00 00 02 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdc, sector 118728
Buffer I/O error on device hdc, logical block 29682
Buffer I/O error on device hdc, logical block 29683
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }

Another link on the net (by the same poster as the LKML link above) mentioned that this problem appears *after* kernel 2.6.16. So I downgraded my Slackware kernel to 2.6.16 and sure enough the problem goes away. I haven't tried with the 2.6.19 kernel, so I can't confirm if that solves the problem or not. 

Thanks,
Rakhesh

ps. Am not subscribed to this list. Please cc me any replies etc. Thanks. 




 
____________________________________________________________________________________
Have a burning question?  
Go to www.Answers.yahoo.com and get answers from real people who know.

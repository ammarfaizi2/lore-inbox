Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131789AbRCOSdL>; Thu, 15 Mar 2001 13:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131793AbRCOSdB>; Thu, 15 Mar 2001 13:33:01 -0500
Received: from pat.uio.no ([129.240.130.16]:47757 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S131789AbRCOScr>;
	Thu, 15 Mar 2001 13:32:47 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: chip@valinux.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E14dImS-0006DX-00@traeki.engr.valinux.com> (chip@valinux.com)
Subject: Re: Remote Management (was Re: Alert on LAN)
MIME-Version: 1.0
Message-Id: <E14dcXV-0006J0-00@morgoth>
Date: Thu, 15 Mar 2001 19:31:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Chip Salzenberg]
> IBM says, as quoted by Terje Malmedal:
>> With the latest release, Alert on LAN 2 now extends IT
>> capabilities to remotely manage and control their
>> networked PCs:
>> 
>> Remote system reboot upon report of a critical failure 
>> Repair Operating System 
>> Update BIOS image 
>> Perform other diagnostic procedures 

> OK, fine... but: Where are the authentication and authorization?!
> Surely I'm not the only person to see in this "Alert On LAN 2" the
> potential for a security disaster.  I know I will never buy anything
> that supports AOL2 until its security features are openly documented
> and testable.

Definitely scary possibilites there. I think the best we can
realistically hope for is that you can require a password to be sent
with each packet.

>> The feature I really need is to be able to reset the machine
>> remotely when Linux is hung.

> Some current PC motherboards support remote management via a serial
> line.  Of course, you'll need software: The VA Cluster Manager (GPL'd
> - http://sourceforge.net/projects/vacm) can monitor and control any
> number of clients, limited only by the number of serial ports you can
> give it.  VACM also includes optional client support for enhanced
> monitoring, e.g. of temperatures.  I'm not sure which motherboards it
> supports, but I'm sure you can find current documentation.  :-)

I am aware of some motherboards where you can configure the BIOS via
RS232. What I want is some way to actually reset a machine that is
hung. Currently we are using power-strips where we can switch on and
off individual plugs by telneting to the strip.

We also use Netra T1's from SUN. They have a small microprosessor
listening on the serial port. If you send the escape sequence #. it
will take over and allow you to reset or power-cycle the real
computer. Very cool stuff: 
lom>version
LOM version: 2.1
LOM checksum: 7CA3
LOM firmware build Aug  6 1999 09:46:27
lom>help
The following commands are supported:

alarmon
alarmoff
check
console
environment
faulton
faultoff
help
poweron
poweroff
reset
show
version
lom>environment
LEDs:
faultled OFF
Alarm1 = OFF
Alarm2 = OFF
Alarm3 = OFF

Fans:
1 = OK speed = 74%
2 = OK speed = 74%
3 = OK speed = 74%

PSUs:
1 = OK

This functionality is what I hope Alert on LAN2 can give me.

-- 
 - Terje
malmedal@usit.uio.no

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDSPcx>; Thu, 19 Apr 2001 11:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDSPce>; Thu, 19 Apr 2001 11:32:34 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:31244 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S129346AbRDSPcc>;
	Thu, 19 Apr 2001 11:32:32 -0400
Message-ID: <25369470B6F0D41194820002B328BDD27C8E@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Bug in serial.c 
Date: Thu, 19 Apr 2001 11:32:20 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing some embedded development with the 2.4.x series and have noticed
a few things..

1) In 2.4.2 in order to compile with module support you also had to turn on
smp support.  This has been fixed in the 2.4.3 release.  This bloated the
kernel image to 600k+ which in an embedded world is not a good thing :-)

2) In 2.4.3 the console port using ttySX is broken.  It dumps fine to the
terminal but when you get to a point of entering data (login, configuration
scripts, etc) the terminal does not accept any input.  

So far I have been able to debug to the point where I see that the kernel is
receiving the characters from the serial.c driver.  But it never echos them
or does anything else with them.  I will continue to look into this at this
end.  

I was also wondering if anyone else has seen this or if a patch is avail for
this bug??

Marc Karasek
Sr. Firmware Engineer
iVivity Inc
marc_karasek@ivivity.com  

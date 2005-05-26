Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVEZRwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEZRwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVEZRwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:52:22 -0400
Received: from smtpout19.mailhost.ntl.com ([212.250.162.19]:57870 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261662AbVEZRwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:52:16 -0400
Message-ID: <42960CCA.5020703@smallworld.cx>
Date: Thu, 26 May 2005 18:52:10 +0100
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.30 - USB serial problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

We recently upgraded from 2.4.24 to 2.4.28 and the problem described 
below appeared. I have tested it on 2.4.30 and the fault still exists.

It is something to do with usb serial. We are actually using the 
ftdi_sio module but a quick diff suggests it hasn't changed much. I am 
not 100% sure what is going on but we are sending out various short 
commands (11 bytes) to an external device. Most work just fine but one 
using one sequence seems to cause the driver to loop and continually 
send out the same command. The application keeps sending other commands 
but eventually the write () blocks and that's that.

Examining the packet that caused the problem showed it was very similar 
to the others but it contained 0x0a. This obviously stuck out as being a 
candidate for some sort of translation problem.

I also built a 2.4.28 kernel with the ftdi_sio and usbserial code from 
the 2.4.24 release. It also failed. This was a surprise and I am 
wondering of I did it correctly.


I don't have the failing equipment with me here but will return to site 
next week. I would appreciate any words of wisdom on the problem.


-- 
Ian Leonard

Please ignore spelling and punctuation - I did.

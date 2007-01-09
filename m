Return-Path: <linux-kernel-owner+w=401wt.eu-S1751027AbXAIERf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXAIERf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXAIERf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:17:35 -0500
Received: from web50802.mail.yahoo.com ([206.190.38.111]:41692 "HELO
	web50802.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750712AbXAIERe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:17:34 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 23:17:34 EST
Message-ID: <20070109041054.85826.qmail@web50802.mail.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ILJo2nTEPPm4KNghvUyRrqMvm4KOvaDtJzc1R9Ukg7V50MU/3fDFUE5agkOh8CX60yTLfzXH8BKiWwuSYBSH8tNNIDFk5g49BxfuBCobcs0Ui8XrtsZLWPS2CmzmHTIUEKZEQ4bS7SlcpG6JHg7d65CT/LHFDDPpmoy4qMXeBkI=;
X-YMail-OSG: tt2l7mgVM1kjTfTviN2TwH8Xlz44dUr2k_SkFxNWuaIdQPZGac8EMnFSstAPq5ZlQDiT2p2jDonQbJSoM2L.rvX3.K.KrxasIKpdnqigC5hUgvU9awumCUuDAjGtebDruG0tLYIXQZeGnRY2R2WZvAoHPA--
Date: Mon, 8 Jan 2007 20:10:54 -0800 (PST)
From: Robert Hirsh <rkhirsh@yahoo.com>
Subject: Keyspan USA-49WLC driver broken in 2.6.18, 4.6.19, and  2.6.20 kernels
To: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-userss@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: Keyspan USA-49WLC driver broken in 2.6.18,
4.6.19, and  2.6.20 kernels

Description: The Keyspan USB driver module
(CONFIG_USB_SERIAL_KEYSPAN_USA49WLC) that is part of
the 2.4.18,2.4.19, and 2.4.20 kernels does not work on
the Keyspan USA-49WLC (USB->4 serial port device).
Specifically, the driver allows the USA-49WLC to send
serial data, but it is unable to read any serial data
back on the port. I have connected 2 of the ports
together (using a null-modem) and opened 2 “minicom”
windows (one for each of the ports). Under kernel
2.4.17 (and earlier), I get the expected behavior, and
whatever I type in one window shows up in the other
window. However for the newer kernels, I get nothing.
The green led on the device flashes on the
“transmitting” port every time I hit a key, however
the “receiving” one does not flash (like it does when
the device is working properly). When I use an older
kernel (or even windows), both lights flash as would
be expected.

  NOTE:  Actually, the first time a character is sent
to the port, it will blink a single time, but only the
first one, and it will not blink again unless the USB
device is unplugged/replugged. After the replug, it
will once again blink exactly once on the receive
side. 


    The transmitted serial data seems to be OK, since
when I connect the USA-WLC to a standard serial port,
I can see the outgoing data properly. However, the
USA-WLC still cannot receive any data, even when
connected to a standard serial port. 

Keywords: USB to serial, Keyspan USA-49WLC, 2.6.19,
2.6.20, 2.6.18, CONFIG_USB_SERIAL,
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC

Kernel versions: 2.6.18, 2.6.19, 2.6.20

Thanks for any help/advice you can give!


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

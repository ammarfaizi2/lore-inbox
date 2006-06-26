Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWFZPvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFZPvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWFZPvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:51:52 -0400
Received: from k2smtpout02-02.prod.mesa1.secureserver.net ([64.202.189.91]:44168
	"HELO k2smtpout02-02.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1750720AbWFZPvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:51:51 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.4/5.0):. Processed in 1.309254 secs Process 22683)
Message-ID: <44A002C3.9000807@plutohome.com>
Date: Mon, 26 Jun 2006 18:52:35 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB & Sysfs Question ( posible issue )
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If i had a usb-serial device in linux, i can/could find a symlink in 
/sys/bus/usb-serial/devices named ttyUSBX that is/was pointing to 
another sysfs directory, which is in /sys/device. The directory in the 
/device looked something like this : 
/devices/pci0000:00/0000:00:02.0/usb1/1-3/1-3:1.0/ttyUSBX . As far i 
could figure out the '... usb1/1-3/...' part from the path means that 
the device is connected to the port 3 of the 1st usb controler.

I used this for a long of time to uniquely identify phisical usb ports 
from a computer, when upgrading to 2.6.17, something strange started to 
happen: even if i didn't remove the usb device from a specified port of 
a the computer, sometimes when rebooting the usb controlers changed 
their numbers in sysfs. A device that was before the reboot 
'...usb1/1-3/...' can be now ' ...usb2/2-3...' or '...usb4/4-3...'.

The main idea is that an usb port can't no loger be identified only by 
looking on it's sysfs path. Is this a normal behavior ? I'm asking this 
as i didn't get this numbering change when using older 2.6 kernel.

Thanks

--
Razvan Gavril

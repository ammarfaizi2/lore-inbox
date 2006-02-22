Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWBVKoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWBVKoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 05:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBVKoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 05:44:07 -0500
Received: from gw.webart.net ([195.30.14.5]:42978 "EHLO gw.webart.net")
	by vger.kernel.org with ESMTP id S1750897AbWBVKoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 05:44:05 -0500
Message-ID: <43FC405E.7010705@packetalarm.com>
Date: Wed, 22 Feb 2006 11:43:42 +0100
From: Nils Rennebarth <nils.rennebarth@packetalarm.com>
Organization: Varysys GmbH & Co. KG
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Loading e100 and uhcd-hcd at (almost) same time disables IRQ with
 2.6.16-rc4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Feb 2006 10:37:56.0534 (UTC) FILETIME=[0AFBD560:01C6379C]
X-Commtouch-RefId: str=0001.0A090207.43FC4043.0009,ss=1,fgs=0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with a supermicro P3TSSE mainboard, with an Intel 815E chipset, where 
the two integrated network adapters (Intel82559 10/100 Ethernet) and one of the 
two usb host adapters share the same IRQ (irq 11).

When udev synthesizes hotplug events during boot and there is interrupt activity
(e.g. by flood pinging one interface) I get an "irq 11: nobody cared" message 
followed by a traceback and "Disabling IRQ #11". After that unsurprisingly both 
network adapters are dead which is unfortunate as this usually is a headless 
server machine.

I reproduced the problem on another identical hardware, so faulty hardware is 
(almost) ruled out. The bug is already present in 2.6.14, I did not try to trace 
it farther back.

dmesg from normal and failed boots and further info can be found on
http://bugzilla.kernel.org/show_bug.cgi?id=5918


-- 

Mit freundlichen Grüßen / with kind regards

Nils Rennebarth
--
VarySys Technologies GmbH & Co. KG
Moenchhaldenstraße 28
70191 Stuttgart
Germany
Tel +49 711 2501198
Fax +49 711 2501197
mailto:Nils.Rennebarth@packetalarm.com
http://www.packetalarm.com

Download the free software trial version of PacketAlarm now
http://www.packetalarm.com/download/

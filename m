Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272499AbTGZQWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTGZQWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:22:19 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:9477 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272499AbTGZQWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:22:18 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Does sysfs really provides persistent hardware path to devices?
Date: Sat, 26 Jul 2003 20:36:13 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307262036.13989.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I can tell sysfs device names include logical bus numbers which 
means, if hardware is added or removed it is possible names do change.
 
Example:

/sys/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.1/2-2.1:0/host1/1:0:0:0

PCI part reflects bus number. Now this example is trivial in that it is 
integrated USB controller so it is unlikely to ever change its number - but 
if it were external controller (and even worse with PCI-to-PCI bridge) it is 
likely that adding extra card would shift all numbers.

And USB part of name starts with logical USB bus number i.e. it is obvious 
that adding one more USB adapter will definitely change it.

So apparently I cannot rely on sysfs to get reliable persistent information 
about physical location of devices.

the point is - I want to create aliases that would point to specific slots. 
I.e. when I plug USB memory stick in upper slot on front panel I'd like to 
always create the same device alias for it.

TIA

-andrey

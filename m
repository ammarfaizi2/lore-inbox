Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264554AbUEDSI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbUEDSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUEDSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:08:56 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:56966 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S264554AbUEDSIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:08:53 -0400
Subject: [Bluetooth] hci_usb + sonypi
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1083694169.13271.13.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 20:09:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to active bluetooth on a Vaio Picture Book C1-MZX
(http://www.japanrush.com/pcg-c1mzx.asp). 

I have first compiled bluetooth with the following options:

# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
# CONFIG_BT_SCO is not set
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
 
#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
...
(the rest is set to "no")


Then, I followed this web page:
http://www.holtmann.org/linux/bluetooth/vaio.html

At the end, I have the following lsmod:
Module                  Size  Used by
hci_usb                11168  0
rfcomm                 40124  0
l2cap                  25508  5 rfcomm
bluetooth              51556  5 hci_usb,rfcomm,l2cap
sd_mod                 18400  0
usb_storage            29664  0
ohci_hcd               19620  0
usbcore               105916  5 hci_usb,usb_storage,ohci_hcd
nls_iso8859_1           3904  1
ntfs                  101612  1
sonypi                 23456  0
thermal                13200  0
processor              17616  1 thermal
fan                     3980  0
button                  6040  0
battery                 9356  0
ac                      4812  0

Unfortunately, I have the following error message when trying to
activate the device (hciconfig hci0 up):

Can't get device info: No such device

And hciconfig -a doesn't give any output.

I have to add that I am using this with udev on my system (I don't know
if it is relevant to say it but as the system is complaining about a
missing device...).

Does anybody have some clue to get this to work ?

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271317AbTGWUxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271318AbTGWUxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:53:32 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:62370 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S271317AbTGWUx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:53:27 -0400
Message-Id: <5.1.0.14.2.20030723140628.096fcbe0@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Jul 2003 14:08:25 -0700
To: Florian Lohoff <flo@rfc822.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [2.4.21] bluez/usb-ohci bulk_msg timeout
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030723142035.GA956@paradigm.rfc822.org>
References: <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com>
 <20030718173214.GD15430@paradigm.rfc822.org>
 <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:20 AM 7/23/2003, Florian Lohoff wrote:
>On Mon, Jul 21, 2003 at 10:06:19AM -0700, Max Krasnyansky wrote:
>> At 10:32 AM 7/18/2003, Florian Lohoff wrote:
>> 
>> >Hi,
>> >since 2.4.21 + mh2 bluez patch i am seeing these errors. 2.4.20 + mh7
>> >bluez patch did not show these errors. Results are very instable
>> >Bluetooth connections.
>> Those errors don't seem to be related to the driver update. But you could
>> try this. In drivers/bluetooth/hci_usb.h set HCI_MAX_BULK_TX define to 1 (instead of 4)
>> and rebuild the module. Does it make any difference ?
>
>Doesnt help at all - So the OHCI changes are to blame ?
Probably. Could try the prev revision of the HCI USB driver though. ie The one without SCO
support. Just copy hci_usb.[ch] over from older kernel and see if it works with newer OHCI.

Max


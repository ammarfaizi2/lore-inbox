Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVJQTp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVJQTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVJQTp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:45:26 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:22237 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751296AbVJQTpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:45:25 -0400
Message-ID: <4353FF4F.6060102@ens-lyon.org>
Date: Mon, 17 Oct 2005 21:45:19 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: orinoco messages killing the box
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a orinoco wireless pcmcia card on 2.6.14-rc4.
The driver works great but I just got a little problem.

Something wrong occured on my laptop (I don't know what)
causing the orinoco driver to print
	wifi: Error -16 transmitting packet
(wifi is the name of the interface).

The problem is that I got such a message each millisecond.
This took 100% CPU, completely locking the box, until I removed
the pcmcia card.

What I now see in /var/log/messages is:

hermes @ 00012100: Card removed while waiting for command 0x0011 completion.
hermes @ 00012100: Card removed while waiting for command 0x0021 completion.
printk: 4567 messages suppressed.
printk: 4564 messages suppressed.
nsmitting packet
printk: 4566 messages suppressed.
printk: 4603 messages suppressed.
<3: Error -16 transmitting packet
<nsmitting packet
: Error -16 transmitting packet
<: Error -16 transmitting packet

Actually, the card got removed _after_ all these messages.
It was still supposed to be plugged when the "Card removed"
messages appeared.

Is there any way to avoid this message flooding ?
Or is this kind of error so rare that it is not worth doing it ?

Regards,
Brice Goglin

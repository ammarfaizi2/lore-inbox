Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVL0SDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVL0SDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 13:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVL0SDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 13:03:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27815 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932362AbVL0SDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 13:03:01 -0500
Date: Tue, 27 Dec 2005 19:02:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
In-Reply-To: <200512251617.09153.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0512271859240.3068@yvahk01.tjqt.qr>
References: <200512130219.41034.dtor_core@ameritech.net>
 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
 <Pine.LNX.4.61.0512252207020.15152@yvahk01.tjqt.qr> <200512251617.09153.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It does not work here on a SONY VAIO U3. After loading the sonypi module, 
>> neither mev nor showkey return something for the special stuff like 
>> jogwheel, jogbutton or Fn keys respectively.
>> 
>> Running 2.6.15-rc7, this appeared in the kernel log:
>> Dec 25 22:06:14 takeshi kernel: sonypi: request_irq failed
>
>Just in case I am sending corrected patch.
>
Ok now it works. (Just like with the old sonypi :-)

However, there are some things that remain unresolved:
- the "mousewheel" reports only once every 2 seconds when constantly
  wheeling (in mev)
- pressing the jogdial button produces a keyboard event (keycode 158) 
  rather than a mousebutton 3 event

BTW, how can I use the Fn keys on console (keycodes 466-477) for arbitrary 
shell commands?
Such a feature, among which special combinations like Ctrl+Alt+Del also 
belong, are handled by the kernel which leaves almost no room for 
user-defined userspace action. Any idea?



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/

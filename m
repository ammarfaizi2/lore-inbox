Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425331AbWLHKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425331AbWLHKZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425332AbWLHKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:25:10 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:48532 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425331AbWLHKZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:25:08 -0500
Message-ID: <45793D82.1040807@s5r6.in-berlin.de>
Date: Fri, 08 Dec 2006 11:25:06 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       DervishD <lkml@dervishd.net>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <fa.nPT9ZJ5poT8fZx3aWy0MqRK/gto@ifi.uio.no> <fa.aML3aAeWqfac08XNpQa7Zu0AC8w@ifi.uio.no> <4578D97F.7020107@shaw.ca> <45792B4D.8050705@citd.de>
In-Reply-To: <45792B4D.8050705@citd.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Robert Hancock wrote:
>> Matthias Schniedermeyer wrote:
>>> I have a 1,5 Meter and a 4,5 Meter cable connected to the USB-Controller
>>> and i only use of them depending on where the HDD is placed in my room,
>>> the other one is dangling unconnected.
>>>
>>> Then i will unconnect the short cable and use the long cable exclusivly
>>> and see if it gets better(tm).

BTW, I suspect front panel connectors could introduce noise too, via the
jumper cables from motherboard to the panel.

>> That long cable could be part of the problem - I don't think the USB
>> specification allows for cables that long (something like a 6 foot max
>> as I recall).
> 
> http://en.wikipedia.org/wiki/USB2
> 
> Says that 5 meters are allowed.

I don't know about USB 2.0, but in case of FireWire, ~4.5m long cables
are theoretically in spec too. I've got a FireWire 400 and a FireWire
800 cable this long, and both don't work very unreliable. Depending on
what's connected, they fail sooner or later. However due to how FireWire
works, this is immediately noticed as data CRC errors or bus resets.
I.e. it's nearly impossible for noisy hardware to _silently_ cause data
corruption. I would suppose USB has similar CRC checks.

Also, you mentioned that the corruption occurs systematically on certain
byte patterns. Therefore it's certainly not related to the cables.
-- 
Stefan Richter
-=====-=-==- ==-- -=---
http://arcgraph.de/sr/

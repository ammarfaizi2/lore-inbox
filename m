Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbULFLJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbULFLJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULFLJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:09:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:52362 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261493AbULFLJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:09:46 -0500
Message-ID: <41B43D78.4000509@datafloater.de>
Date: Mon, 06 Dec 2004 12:07:36 +0100
From: Arne Caspari <arne@datafloater.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hpsb protocol driver: probe callback not called
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List!

I am working on a video-4-linux driver for IEEE-1394 cameras. The driver 
exposes a struct ieee1394_device_id table to match devices on a certain 
specifier.

If I specify a match for a specifier_id of 0xa02d and a version of 
0x100, the "probe" callback supplied via "hpsb_register_protocol" is 
never called, even if such a device is connected.

The driver is loaded by "hotplug" though so obviously the match is correct.

Now if I change the supplied specifier_id to match some other device and 
leave the rest of the code just alike, the "probe" callback _is_ called.

The only difference between the two situations I can spot is that for 
the specifier_id of "0xa02d", there are already two modules registered: 
raw1394 and video1394. For the specifier_id of the other device, there 
is no other registered driver.

Am I missing something obvious? Or is it really not possible to register 
a driver for a device that has a match on some other driver? Or is it 
just a bug in the ieee1394 node manager?


Thanks,

 /Arne

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUIEC1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUIEC1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUIEC1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:27:48 -0400
Received: from dev.tequila.jp ([128.121.50.153]:33801 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S265977AbUIEC1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:27:45 -0400
Message-ID: <413A799C.1000505@tequila.co.jp>
Date: Sun, 05 Sep 2004 11:27:40 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: external firewire dvd writer
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have an external Pioneer DVD writer which I connect via Firewire to my
laptop. So when I turn it on I get this in my dmesg:

drivers/usb/input/hid-input.c: event field not found
ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Error parsing configrom for node 0-01:1023
ieee1394: Error parsing configrom for node 0-02:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00e03600500008f2]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Logged out of SBP-2 device
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
scsi2 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
~  Vendor: PIONEER   Model: DVD-RW  DVR-105   Rev: 1.20
~  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 5

Problem now is, that it stays on /dev/sg2. There is no more mapping. The
output of sg_map is this:

pluto:~# sg_map
/dev/sg0  /dev/sda
/dev/sg1  /dev/sdb
/dev/sg2

[sg0 is the internal Sony Memory Stick reader, sg1 is an external Maxtor
200 GB Firewire HD]

So is there anything wrong with hotswap? or which part doesn't make the
connection from sg2 to any cd device. The problem is, which just sg2 I
(as user) can't do much as sg2 is just root rw ...

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBOnmbjBz/yQjBxz8RAhroAKCr9mWlvGP45irNS6KrKYf2UGEvxgCgtjTu
XDk09VpXU9lq8j82/ZvwSlw=
=AAH7
-----END PGP SIGNATURE-----

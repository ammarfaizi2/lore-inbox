Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTLSNKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTLSNKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:10:52 -0500
Received: from smtp120.tiscali.dk ([62.79.79.111]:16632 "EHLO
	smtp120.tiscali.dk") by vger.kernel.org with ESMTP id S263387AbTLSNKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:10:50 -0500
Message-ID: <3FE2F8D4.1030903@agol.dk>
Date: Fri, 19 Dec 2003 14:10:44 +0100
From: Niels Elgaard Larsen <elgaard@agol.dk>
Reply-To: elgaard@agol.dk
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem loopmounting CD on 2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A similar (probably the same) problem have been reported for cryptoloop.
With a ISO9660 CD (actually Knoppix) in drive /dev/hdc, no SCSI emulation:

amigos20:/mnt# losetup /dev/loop5 /dev/hdc
amigos20:/mnt# mount -r /dev/loop5 /mnt/foo

Gives kernel output:

===
hdc: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdc, sector 64
isofs_fill_super: bread failed, dev=loop5, iso_blknum=16, block=32
===

It works in 2.4.20

Also

dd if=/dev/hdc of=/tmp/foo
losetup /dev/loop5 /tmp/foo
mount -r /dev/loop5 /mnt/foo

works

-- 
Niels Elgaard Larsen
elgaard@agol.dk
http://www.agol.dk/elgaard


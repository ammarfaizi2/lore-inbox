Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUIONg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUIONg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUIONg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:36:29 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:44818 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266149AbUION2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:28:41 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Version 0.97 of linld is available
Date: Wed, 15 Sep 2004 16:28:00 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409151628.00579.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linld is a Linux boot loader for DOS,
similar to loadlin.

It was written because I failed to find out why
loadlin cannot load new, larger kernel images.
I stuck to using C and ended up with fairly small
code, partially because linld have no support for
ancient kernels.

New version addresses the following issue:
kernel (at least 2.6 one) does not believe in incomplete
last RAM page, so if boot loader places initrd image
sot that it's tail end up in that last page,
kernel thinks that initrd is truncated and drops it.

I bas bitten by this when I tried booting on a machine
which had only 3 kb out of 4 in it's last RAM page
(1 kb reserved for BIOS or something like that).

Available at:
http://195.66.192.168/linux/linld/

HISTORY file
=======
Acknowledgements
----------------
Lots of code was borrowed from loadlin source
(author of loadlin is Hans Lermen <lermen@elserv.ffm.fgan.de>).
Some code from linux kernel (setup.S) was used too.
Thank you guys!

Todo
----
?

Changelog
---------
0.91    Added support for cl=@filename
0.92    VCPI vodoo magic: booting under EMM386 and foes :-)
0.93    Cleanup. cl=@filename: cr/lf will be converted to two spaces
0.94    Ugly workaround for DOS int 15 fn 88 breakage
0.95    Bug squashed: vga=NNN did not like dec numbers, oct/hex only
        Some VCPI comments added
0.96    Do not lowercase entire command line
0.97    memtop() must be rounded down to page boundary
--
vda


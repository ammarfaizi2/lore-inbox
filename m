Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWA0HQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWA0HQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWA0HQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:16:15 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:62924 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751408AbWA0HQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:16:15 -0500
Message-ID: <43D9C8C5.3020902@t-online.de>
Date: Fri, 27 Jan 2006 08:16:21 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: netboot broken ?
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: Tbwxs6ZXYeU5EsYwuM9n9dydqQYDGBzvIN3etP+Dmucv191A8HZuZA@t-dialin.net
X-TOI-MSGID: a703a14a-313f-416c-aa8e-405bedb9312c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

I spent too many hours trying to boot a machine via ethernet.
The nic includes a pxe boot rom, and without any problems I
manage to boot an old DOS disk image and memtest.

There are also no problems to _load_ the linux kernel.

But when it reaches the point of ip autoconfiguration
(I included ip=dhcp on the kernel command line and, of course,
I enabled dhcp autoconfiguration in the .config), nothing works.
It sends dhcp requests, dhcpd answers, and this repeats forever.
Well ... this is the second time dhcpd is asked ... without a
working and basically correct configured dhcpd the pxe boot
rom and pxelinux would have been unable to  load the kernel ?!

Ok, there is the possibility not to use dhcp autoconf but to
give the necessary information via ip=.... to the kernel. That
works. But after ip config the kernel needs to connect the server to
get the port of rpc 100003/2 and 100005/1. Both fail and timeout,
the kernel tells me to try the defaults, fails and panics.

Please don´t tell me that I forget to start nfsd or mountd, that I
did not export the filesystem the kernel tries to mount etc. I
have no problems to mount that directory from other machines
on the network.

I tried a number of recent kernels, the oldest was 2.6.14.

Any ideas? Can anybody please
 - confirm that network booting does still work
 - confirm that it is broken.

Yes, I read Documentation/nfsroot ... and I am willing to update
it if anybody tells me how to boot that machine.

cu,
 Knut

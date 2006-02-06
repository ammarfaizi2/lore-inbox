Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWBFPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWBFPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBFPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:49:09 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:47280 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932092AbWBFPtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:49:08 -0500
Message-ID: <43E7700F.6080702@t-online.de>
Date: Mon, 06 Feb 2006 16:49:35 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Carlos Carvalho <carlos@fisica.ufpr.br>
CC: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
References: <43E70BE3.1080805@t-online.de> <17383.24476.747110.629245@fisica.ufpr.br>
In-Reply-To: <17383.24476.747110.629245@fisica.ufpr.br>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: bM+v9BZ6oehRIFcCAdstoSHmgmSFQF4R3JGjNPKx6z2hwdZl1ifssV@t-dialin.net
X-TOI-MSGID: 5ee9cc55-1873-4af6-bbc8-b1e355a00433
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Carvalho wrote:

>Yes, this works fine. The kernel gets it from pxelinux directly via
>option IPAPPEND.
>
>Here's what I copied manually from the screen after the IP-Config:
>line:
>
>  
>
That was not what I asked. Please test without ipappend
and use ip=dhcp as a kernel parameter instead. Don´t forget
to enable dhcp autoconfiguration in the kernel config ...

I bet that you will see that the same dhcp server that proved to
work correctly by providing your server ip etc to the
pxe bootrom and via ipappend to the kernel is unable to
give that same information to the linux ipconfig code
directly. Please try and report.

I assume that you do not have any problem to pxeboot good
old DOS and memtest. Right?

Please give board name, bios version, pxe rom version, and
lspci -vv.

>Trond asked about using tcp. I prefer to use udp because it has less
>overhead. This is a computing cluster, all machines are in the same
>room connected to a HP 4108gl gigabit switch. It's not a cable or
>switch port problem, all machines exhibit the same behavior.
>  
>
If I am right with my bet the problem is unrelated to the tcp / udp
choice and unrelated to ipconfig, portmap lookup and nfsroot code.



cu,
 Knut

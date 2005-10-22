Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVJVMSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVJVMSz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 08:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVJVMSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 08:18:54 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:56283 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751330AbVJVMSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 08:18:54 -0400
Message-ID: <435A2E2C.4080205@rtr.ca>
Date: Sat, 22 Oct 2005 08:18:52 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Raphael Jacquot <raphael.jacquot@imag.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: problem with libata and ich6m - 2.6.14-rc5
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br> <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br> <43290893.7070207@pobox.com> <435A28C2.3000104@imag.fr>
In-Reply-To: <435A28C2.3000104@imag.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Jacquot wrote:
> hi
> I have a Dell inspiron 6000 with the following hardware :
> 
> 0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA 
> Controller (rev 03) (prog-if 80 [Master])
>         Subsystem: Dell: Unknown device 0188
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>
> problem is, it doesn't attach the dvd drive properly...

libata is being paranoid about ATAPI devices,
and as of 2.6.14* it refuses to manage them unless you
supply the atapi_enabled=1 parameter to the kernel.

For built-in libata, use "libata.atapi_enabled=1" in your /boot/grub/menu.lst,
and for libata as a loadable module, put "options libata atapi_enabled=1"
into your /etc/modprobe.conf file (or whatever the nom de jour is for that).

Cheers

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUDYUVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUDYUVA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 16:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUDYUVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 16:21:00 -0400
Received: from pop.gmx.de ([213.165.64.20]:35530 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261984AbUDYUUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 16:20:55 -0400
X-Authenticated: #555161
Message-ID: <408C1DE2.4070704@hasw.net>
Date: Sun, 25 Apr 2004 22:21:54 +0200
From: Sebastian Witt <se.witt@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
References: <40898ADA.8020708@hasw.net> <200404250331.25606.bzolnier@elka.pw.edu.pl> <408BFD32.7090202@hasw.net> <200404252147.05725.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200404252147.05725.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------000506010606060808060605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506010606060808060605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

> On Sunday 25 of April 2004 20:02, Sebastian Witt wrote:
>>Thanks, this patch works. I've tested now multiple times a 2.6.5 kernel
>>with and without this patch. The BIOS of my controller is also disabled
>>if this is important...
> 
> Thanks.  Can you retest with enabled BIOS?

If I find it ;-). It was removed some time ago because
sometimes the computer doesn't start when the controller was plugged in.

> Please also send me output output of 'cat /proc/ide/ide2/config'
> and 'cat /proc/ide/ide3/config' before and after applying this patch.

No problem.

Regards,
Sebastian

--------------000506010606060808060605
Content-Type: text/plain;
 name="ide2-patched"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide2-patched"

pci bus 00 device 88 vendor 105a device 4d38 channel 0
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 5a 10 33 4d
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d4 23 41 00 d4 23 41 00 d4 23 41 00 d4 23 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d4 23 41 00 d4 23 41 00 d4 23 41 00 d4 23 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

--------------000506010606060808060605
Content-Type: text/plain;
 name="ide2-unpatched"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide2-unpatched"

pci bus 00 device 88 vendor 105a device 4d38 channel 0
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 5a 10 33 4d
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
11 24 41 00 11 24 41 00 11 24 41 00 11 24 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
11 24 41 00 11 24 41 00 11 24 41 00 11 24 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

--------------000506010606060808060605
Content-Type: text/plain;
 name="ide3-patched"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide3-patched"

pci bus 00 device 88 vendor 105a device 4d38 channel 1
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 5a 10 33 4d
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d4 23 41 00 d4 23 41 00 d4 23 41 00 d4 23 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d4 23 41 00 d4 23 41 00 d4 23 41 00 d4 23 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

--------------000506010606060808060605
Content-Type: text/plain;
 name="ide3-unpatched"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide3-unpatched"

pci bus 00 device 88 vendor 105a device 4d38 channel 1
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 5a 10 33 4d
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
11 24 41 00 11 24 41 00 11 24 41 00 11 24 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a 10 38 4d 07 00 00 02 01 00 04 01 00 20 00 00
01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
01 dc 00 00 00 00 00 d9 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00
11 24 41 00 11 24 41 00 11 24 41 00 11 24 41 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

--------------000506010606060808060605--


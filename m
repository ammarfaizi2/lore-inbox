Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTDFVyT (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTDFVwd (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:52:33 -0400
Received: from 078-037.onebb.com ([202.69.78.37]:18123 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id S263121AbTDFVvG (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:51:06 -0400
Message-ID: <3E90A3E6.1F40D577@vtc.edu.hk>
Date: Mon, 07 Apr 2003 06:02:14 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-8custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?)
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
	 <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk> <20030406203145.GA5783@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Sun, Apr 06, 2003 at 07:34:09PM +0100, Alan Cox wrote:
>  > > 02:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
>  > > 02:0b.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
>  > ...
>  > Your choice of components looks fine, its all stuff I trust, even if the
>  > ethernet card is not good for performance it ought to be fine in
>  > general. If it is a faulty part most likely its a one off fault.
>
> Note the IDE controller, and 2.5 bugzilla #123
> That controller has been nothing but trouble for me.
>
>                 Dave

Yes, it was the first thing I suspected, so I went out to the fabled Golden
Shopping Centre and bought all the alternative disk controllers I could (except
for 3ware, which I lacked the cash for).  I tried HighPoint HPT 370A (Adaptec
1200A), HighPoint HPT368, Promise PDC20270 (FastTrack 100Tx2), and the PDC20276
built onto the motherboard, and a HighPoint HPT302 which didn't work properly at
all.  I still got the lockups with various permutations of the non-Silicon Image
chipsets, and found that to my amazement, the Silicon Image 680 chips gave the
best performance.  I too had major problems with CMD64x boards on a production
2-CPU system (server for student accounts), so remained with SCSI on that
machine.

Bugzilla for the kernel?  I didn't know there is one!  I'd better find it.
Thanks Dave.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24




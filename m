Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbTDIBNL (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDIBNL (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:13:11 -0400
Received: from 081-188.onebb.com ([202.69.81.188]:49586 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id S261924AbTDIBNK (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 21:13:10 -0400
Message-ID: <3E93764A.DC4D1C21@vtc.edu.hk>
Date: Wed, 09 Apr 2003 09:24:26 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-27.8.0dbgpentax i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard J Moore <rasman@uk.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?)
References: <200304072324.32050.rasman@uk.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:

> On Sun 6 April 2003 8:31 pm, Dave Jones wrote:
> > On Sun, Apr 06, 2003 at 07:34:09PM +0100, Alan Cox wrote:
> >  > > 02:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
> >  > > 02:0b.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
> >  >
> >  > ...
> >  > Your choice of components looks fine, its all stuff I trust, even if the
> >  > ethernet card is not good for performance it ought to be fine in
> >  > general. If it is a faulty part most likely its a one off fault.
> >
> > Note the IDE controller, and 2.5 bugzilla #123
> > That controller has been nothing but trouble for me.
> >
> >               Dave
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> Do you know that your platform support a watchdog timer.

Yes, the nmi field in /proc/interrupts was non-zero.

> Not every thing
>  does, thought most do. It's probably worh verifying (cli; hlt;).
> Is it possible you have experiennced a triple-fault? Most CPUs reset but some
> have been known to freeze and require a manual reset. This can be verified
> relatively easily (make int 8 descriptor NP then loop recursively - does the
> system hang or reboot?).

Thank you, I will investigate this.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24




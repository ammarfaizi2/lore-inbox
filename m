Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbRE3Ah2>; Tue, 29 May 2001 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRE3AhT>; Tue, 29 May 2001 20:37:19 -0400
Received: from smtpout.ev1.net ([207.218.192.47]:57096 "EHLO smtp3.ev1.net")
	by vger.kernel.org with ESMTP id <S261758AbRE3AhJ>;
	Tue, 29 May 2001 20:37:09 -0400
Message-ID: <3B144067.60EA@ev1.net>
Date: Tue, 29 May 2001 19:35:51 -0500
From: Robert Redelmeier <redelm@ev1.net>
X-Mailer: Mozilla 3.04 (Win95; U)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 freezes on VIA KT133 -- mine FIXED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > > contrary to the implication here, I don't believe there is any *general* 
> > > problem with Linux/VIA/AMD stability. there are well-known issues 
> ... 
> > VIA hardware is not suitable for anything until we _know_ the 
> > truth about what is wrong. VIA is hiding something big. 
<snip>
> afaik, there are absolutely zero problems reported with kt133-no-a 
> machines, for instance. mine has certainly worked flawlessly for a 
> long time, on most every 2.3/2.4 kernel over the past year+. 

FWIW, I'm shaking down a 8.5*100 T'bird VIA VT8363 (no "A") 
Northbridge & VT82C686A (Southbridge).  KT133 no A.  No HPT366.

I had terrible read errors on a single UDMA66 HD: one in 5 md5sums 
on an unmounted 1.5 GB partition was different.   WD Diags said 
drives were good (sectors verified OK). Swapped PS, RAM, HDs, 
cables, PCI cards, 2.2/2.4/FreeBSD kernels, nothing helped ...  

...  until I slowed the SDRAM down from the PC133 (it really _is_
and passes memtest-86 and my burnMMX)  down to PC100.  At least 
UDMA is still working, even if my RAM is decidedly slower. YMMV

I've now tested 9 hrs copying a 500 MB file back and forth on the
same drive without error.  21 hrs copying back and forth  and 
md5sum'ing from /dev/hdc3 [UDMA66] is OK too.

-- Robert  author `cpuburn`  http://users.ev1.net/~redelm

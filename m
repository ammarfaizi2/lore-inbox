Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSKDTmz>; Mon, 4 Nov 2002 14:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSKDTmz>; Mon, 4 Nov 2002 14:42:55 -0500
Received: from fmr01.intel.com ([192.55.52.18]:58605 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262664AbSKDTmy>;
	Mon, 4 Nov 2002 14:42:54 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000F2ECDBA@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Andrew Morton <akpm@digeo.com>, vasya vasyaev <vasya197@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Machine's high load when HIGHMEM is enabled
Date: Mon, 4 Nov 2002 11:49:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also try to disable BIOS remapping in the BIOS setup menu, if any. I know
some BIOS that forgot to reset the proper memory attribute in the MTRR(s)
after the remapping.

Jun

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@digeo.com]
> Sent: Monday, November 04, 2002 11:28 AM
> To: vasya vasyaev
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Machine's high load when HIGHMEM is enabled
> 
> vasya vasyaev wrote:
> >
> > Hello,
> >
> > First of all - thanks to these people, who responded
> > to my question.
> >
> > I have some news...
> >
> > I've tried kernels:
> > 2.4.19 - the same result
> > 2.5.44 - the same result
> > 2.5.45 - the same result
> >
> > If I take 1 Gb of memory away, then computer works
> > much better, faster (something like without enabled
> > HIGHMEM at all).
> > The same effect takes place if I say mem=1024M while
> > physically box has 2Gb of RAM - everything is fine!
> > But if I start HIGHMEM enabled kernel on this box (2Gb
> > RAM), then it works too slowly...
> >
> 
> Please ensure that the mtrr driver is enabled in kernel config,
> boot with mem=2G and send the output of `cat /proc/mtrr'.
> 
> Also, `dmesg | head -120' would be interesting.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

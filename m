Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTI3No1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbTI3No1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:44:27 -0400
Received: from [195.95.38.160] ([195.95.38.160]:3838 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S261489AbTI3NoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:44:17 -0400
From: Jan De Luyck <lkml@kcore.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.23-pre3] Cache size for Centrino CPU incorrect
Date: Tue, 30 Sep 2003 14:23:15 +0200
User-Agent: KMail/1.5.3
References: <7F740D512C7C1046AB53446D3720017304A790@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304A790@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309301423.18378.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 13 September 2003 00:02, Nakajima, Jun wrote:
> This is a bit old, but try.
>
> Thanks,
> Jun
> ------
> --- linux-2.4.21/arch/i386/kernel/setup.c	2003-06-13
> 07:51:29.000000000 -0700
> +++ new/arch/i386/kernel/setup.c	2003-07-08 17:21:48.000000000
> -0700
> @@ -2246,6 +2249,8 @@
>  	{ 0x83, LVL_2,      512 },
>  	{ 0x84, LVL_2,      1024 },
>  	{ 0x85, LVL_2,      2048 },
> +	{ 0x86, LVL_2,      512 },
> +	{ 0x87, LVL_2,      1024 },
>  	{ 0x00, 0, 0}
>  };
>

This works like a charm. Thanks. Maybe for inclusion in 2.4.23-pre6?

Jan


> > -----Original Message-----
> > From: Jan De Luyck [mailto:lkml@kcore.org]
> > Sent: Friday, September 12, 2003 1:18 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: [2.4.23-pre3] Cache size for Centrino CPU incorrect
> >
> > Hello List,
> >
> > I just noticed this:
> >
> > devilkin@precious:~$ cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 9
> > model name      : Intel(R) Pentium(R) M processor 1600MHz
> > stepping        : 5
> > cpu MHz         : 599.511
> > cache size      : 0 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
>
> pat
>
> > clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
> > bogomips        : 1196.85
> >
> > Somehow, the cache size doesn't seem to be correct. Spec info tells me
> > that this cpu
> > has indeed a 1024kb cache.
> >
> > Any patches to test?
> >
> > Thankx
> >
> > Jan
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
>
> linux-kernel" in
>
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eXW2UQQOfidJUwQRAvYsAJ4sz4DslwL20NTjKR6EUCQ+wBp0xQCeJr3Z
fKU5+c3OpZB2y794BbRF+rs=
=gfTN
-----END PGP SIGNATURE-----


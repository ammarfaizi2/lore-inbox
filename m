Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTDKQjV (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTDKQjU (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:39:20 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:22865 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261290AbTDKQjS (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:39:18 -0400
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ck5
Date: Fri, 11 Apr 2003 11:45:56 -0500
User-Agent: KMail/1.5.1
Cc: kernel@kolivas.org
References: <3E96D711.70404@comcast.net>
In-Reply-To: <3E96D711.70404@comcast.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304111146.00283.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I had almost same experience,  not using xfs here.

			Bob
On Friday 11 April 2003 09:54 am, Walt H wrote:
> Hello,
>
> I've compiled a new kernel using the ck5 patchset you made, but have had
> some problems. It seems that with my configuration, I expose a memory
> leak somewhere. After the system has been up for a while, or if I try to
> compile anything non-trivial (kde-libs for example), The system will use
> up all available memory and further memory alloc's fail. Swap is hardly
> being used in this case. My syslog file does report:
>
>
> Apr 10 19:06:19 waltsathlon kernel: __alloc_pages: 1-order allocation
> failed (gfp=0x1f0/0)
> Apr 10 19:06:19 waltsathlon kernel: __alloc_pages: 0-order allocation
> failed (gfp=0xf0/0)
> Apr 10 19:06:19 waltsathlon kernel: __alloc_pages: 1-order allocation
> failed (gfp=0x1f0/0)
>
> Typically, apps fail although the OOM killer isn't triggered (not sure
> if it's enabled in ck5).
>
> I'm wondering if there's a strange interaction with XFS? I also use the
> Nvidia driver, however, I also tested without loading it and receive the
> same results. My XFS thought is due to the strange behaviour of the
> filesystem with this patchset. When I tried compiling kdelibs, the
> system chugged along until memory was used (15-20 mins) and then the
> compile could no longer proceed. After seeing this and issuing a 'sync',
> the drives thrashed for approx. 30-45 seconds as if flushing unwritten
> data. It's as if writes are being stored indefinitely? Reverting back to
> ck4 and all is well. System info below:
>
> Chaintech 7KDD 760MPX MB
> 2 x AMD 2400MP
> 1 GB ECC Ram
> 2-2 disk striped arrays - 1 software MD, 1 Promise Fasttrak
> XFS filesystem on all mount points except boot
> Compiled with GCC-3.2.2
> glibc-2.3.1
>
> Anything else you need? Please CC as I'm not subscribed. Thanks,
>
> -Walt
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lvFHxJgsCy9JAX0RAiOkAJ9DkYNI33rvcMALBe+xlS1x/6OewACeL5Fo
Dn/sIC5+7+iTIAzlsv/9/2M=
=K1L1
-----END PGP SIGNATURE-----


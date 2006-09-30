Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWI3DeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWI3DeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 23:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWI3DeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 23:34:18 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:5831
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750728AbWI3DeR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 23:34:17 -0400
Message-Id: <200609300331.k8U3ViNR008895@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: jt@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: Your message of "Fri, 29 Sep 2006 18:40:43 PDT."
             <20060930014043.GA10927@bougret.hpl.hp.com>
From: Valdis.Kletnieks@vt.edu
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org>
            <20060930014043.GA10927@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159587104_2769P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 23:31:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159587104_2769P
Content-Type: text/plain; charset=us-ascii

On Fri, 29 Sep 2006 18:40:43 PDT, Jean Tourrilhes said:
> On Fri, Sep 29, 2006 at 06:20:08PM -0700, Andrew Morton wrote:
> > On Fri, 29 Sep 2006 20:01:54 -0400
> > > 
> > > A quick strace of gkrellm finds these likely ioctl's causing the problem:
> > > 
> > > % grep ioctl /tmp/foo2 | sort -u | more
> > > ioctl(13, SIOCGIWESSID, 0xbfbcdb9c)     = 0
> > > ioctl(13, SIOCGIWRANGE, 0xbfbcdbdc)     = 0
> > > ioctl(13, SIOCGIWRATE, 0xbfbcdbbc)      = 0
> 
> 	Excuse me, can you point out wich version of gkrellm you use
> and where to find it, the only version that is listed on my page does
> not use the ESSID ioctl. I want to be sure I'm looking at the same
> thing as you are...

All the pieces:
http://download.fedora.redhat.com/pub/fedora/linux/extras/development/SRPMS/

The particular plugin causing the trouble:
http://download.fedora.redhat.com/pub/fedora/linux/extras/development/SRPMS/gkrellm-wifi-0.9.12-3.fc6.src.rpm

If you're not on a box that has rpm2cpio or similar, yell and I'll
break that .src.rpm up for you - there's basically just an 18K .tar.gz and
a 14K patch in there.

--==_Exmh_1159587104_2769P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHeUgcC3lWbTT17ARAjQmAJ0XlSvnOdcxCTEEVcR8xJ4za5stcgCfZCSv
uVWgxbG36DigNUo5HNTnUoY=
=8Hj/
-----END PGP SIGNATURE-----

--==_Exmh_1159587104_2769P--

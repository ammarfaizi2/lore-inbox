Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSA2ShW>; Tue, 29 Jan 2002 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSA2ShN>; Tue, 29 Jan 2002 13:37:13 -0500
Received: from host-01.pronet.pl ([213.241.42.209]:36615 "EHLO pronet.pl")
	by vger.kernel.org with ESMTP id <S289809AbSA2ShE>;
	Tue, 29 Jan 2002 13:37:04 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Marcin Prejsnar <alex@pronet.pl>
Organization: ProNet s.c.
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Memory problem 2.4.9-2.4.17
Date: Tue, 29 Jan 2002 19:36:50 +0100
X-Mailer: KMail [version 1.3.1]
Cc: "David S. Miller" <davem@redhat.com>, "Paul Mackerras" <paulus@samba.org>,
        "Andrew Morton" <akpm@zip.com.au>
In-Reply-To: <E16Tl3p-00024g-00@alex.pronet.local> <3C56438C.F00994B3@zip.com.au>
In-Reply-To: <3C56438C.F00994B3@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16Vd7j-0001Ve-00@alex.pronet.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia wto 29. styczeñ 2002 07:39, Andrew Morton napisal:
> Looks pretty simple to me?
>
> --- linux-2.4.18-pre7/drivers/net/ppp_generic.c	Thu Oct 11 09:18:31 2001
> +++ linux-akpm/drivers/net/ppp_generic.c	Mon Jan 28 22:38:43 2002
> @@ -1528,6 +1528,7 @@ ppp_decompress_frame(struct ppp *ppp, st
>  			   error indication. */
>  			if (len == DECOMP_FATALERROR)
>  				ppp->rstate |= SC_DC_FERROR;
> +			kfree_skb(ns);
>  			goto err;
>  		}
>
> Marcin Prejsnar wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > [1.] SUMMARY
> >         Error packets received on interface ppp cause free memory
> > decrease.
> >

	Yes !!! Helped !!! I testet this in 2.4.17. Now system works good.

So... that was bug in kernels at least from version 2.4.9 up to 2.4.18-pre7, 
maybe before too (!!!).

-- 
__________________
| Pozdrawiam
| Marcin Prejsnar


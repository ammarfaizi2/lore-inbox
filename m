Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbTCMLFS>; Thu, 13 Mar 2003 06:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbTCMLFS>; Thu, 13 Mar 2003 06:05:18 -0500
Received: from menelao.polito.it ([130.192.3.30]:43273 "HELO menelao.polito.it")
	by vger.kernel.org with SMTP id <S262229AbTCMLFQ> convert rfc822-to-8bit;
	Thu, 13 Mar 2003 06:05:16 -0500
From: Willy Gardiol <gardiol@libero.it>
Reply-To: gardiol@libero.it
To: Herbert Xu <herbert@gondor.apana.org.au>,
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Date: Tue, 31 Dec 2002 12:14:19 +0100
User-Agent: KMail/1.5
References: <E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
In-Reply-To: <E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212311214.20170.gardiol@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I am having this same OOPS with 2.4.20!

i will try your patch...

Alle 10:47, giovedì 13 marzo 2003, Herbert Xu ha scritto:
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> > Code;  c0213ab3 <idescsi_pc_intr+63/360>
> > 00000000 <_EIP>:
> > Code;  c0213ab3 <idescsi_pc_intr+63/360>   <=====
> >   0:   ff 42 18                  incl   0x18(%edx)   <=====
> > Code;  c0213ab6 <idescsi_pc_intr+66/360>
> >   3:   89 3c 24                  mov    %edi,(%esp,1)
> > Code;  c0213ab9 <idescsi_pc_intr+69/360>
> >   6:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
> > Code;  c0213ac0 <idescsi_pc_intr+70/360>
> >   d:   00
> > Code;  c0213ac1 <idescsi_pc_intr+71/360>
> >   e:   e8 ae fc ff ff            call   fffffcc1 <_EIP+0xfffffcc1>
> > c0213774 <idescsi_do_end_request+a4/e0> Code;  c0213ac6
> > <idescsi_pc_intr+76/360>
> >  13:   31 00                     xor    %eax,(%eax)
>
> Does this patch fix the problem?

- -- 

! 
 Willy Gardiol - gardiol@libero.it
 goemon.polito.it/~gardiol
 Use linux for your freedom.

   "La guerra non farà mai finire 
    alcuna guerra, nel migliore dei
    casi sarà stata una guerra in più."

      Gino Strada, Buskashì

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+EXwLQ9qolN/zUk4RAuBXAKCZMpMDJ4O/NUGMSEkg8/gjKIsyEACgsZ0+
ps7JTUlVNud4O8F00jDp4b8=
=pImM
-----END PGP SIGNATURE-----


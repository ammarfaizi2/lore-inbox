Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbSJ1NUT>; Mon, 28 Oct 2002 08:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJ1NUT>; Mon, 28 Oct 2002 08:20:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60176 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262497AbSJ1NUS>; Mon, 28 Oct 2002 08:20:18 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15805.15113.459553.881857@laputa.namesys.com>
Date: Mon, 28 Oct 2002 16:26:33 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] faster kmalloc lookup
In-Reply-To: <200210281318.PAA19085@infa.abo.fi>
References: <3DBBEA2F.6000404@colorfullife.com>
	<3DBAEB64.1090109@colorfullife.com>
	<1035671412.13032.125.camel@irongate.swansea.linux.org.uk>
	<3DBBBB30.20409@colorfullife.com>
	<15805.13847.945978.673664@laputa.namesys.com>
	<200210281318.PAA19085@infa.abo.fi>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: Where `market lock-in' means throwing away the keys.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Alanen writes:
 > >Most kmalloc calls get constant size argument (usually
 > >sizeof(something)). So, if switch() is used in stead of loop (and
 > >kmalloc made inline), compiler would be able to optimize away
 > >cache_sizes[] selection completely. Attached (ugly) patch does this.
 > 
 > Perhaps a compile-time test to check if the argument is
 > a constant, and only in that case call your new kmalloc, otherwise
 > a non-inline kmalloc call? With your current patch, a non-constant
 > size argument to kmalloc means that the function is inlined anyway,
 > leading to unnecessary bloat in the resulting image.

Yes, exactly.

 > 
 > Marcus
 > 

Nikita.

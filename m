Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272156AbRIEMu5>; Wed, 5 Sep 2001 08:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272158AbRIEMuj>; Wed, 5 Sep 2001 08:50:39 -0400
Received: from dns.lineo.fr ([194.250.46.228]:5116 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S272156AbRIEMuZ>;
	Wed, 5 Sep 2001 08:50:25 -0400
Date: Wed, 5 Sep 2001 14:50:39 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6
Message-ID: <20010905145039.A10655@pc8.lineo.fr>
In-Reply-To: <1257554973.999687013@[169.254.198.40]> <NOEJJDACGOHCKNCOGFOMAECKDLAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAECKDLAA.davids@webmaster.com>; from davids@webmaster.com on mer, sep 05, 2001 at 11:57:17 +0200
X-Mailer: Balsa 1.2.pre3
X-Operating-System: Debian SID GNU/Linux 2.4.9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it not be possible with your scheme to package a closed source driver
in an open source wrapper driver and then defeat your tainting technique.

Is it legally possible to copyright a kind of magic number with a copyright
allowing only it's used in open & public source driver ?

Christophe 


Le mer, 05 sep 2001 11:57:17, David Schwartz a écrit :
> 
> > >> 	I think, perhaps, the logic should be that a module
> > >> shouldn't taint the kernel if:
> 
> > >> 	1) The user built the module from source on that machine, OR
> 
> > >> 	2) The module source is freely available without restriction
> 
> > > 	I just realized two things. One, there's a strong argument
> that this
> > > should be an AND, not an OR.
> 
> > And as all distributions would fail (1) in initial form, all
> > distributions would result in tainted kernels. Is this the
> > intent?
> 
> 	They wouldn't taint because the kernel signature would match the
> module
> signatures. I provided more detail on one possible way this scheme would
> work and it's not quite as simple as the summary above suggests.
> 
> 	Basically, when you compile (or install) the kernel, a random
> 'signature'
> goes in. When you compile a module, the signature goes in too. You can
> then
> compare the module's signature to the kernel's signature to ensure they
> were
> compiled as a unit. Unfortunately, this doesn't ensure that the user has
> the
> source.
> 
> 	I suppose, if the module source were freely available, then '2'
> would
> apply. If you keep it as an OR, then distributions wouldn't taint out of
> the
> box unless they included modules whose source distribution was limited. I
> think this is what you want.
> 
> 	DS
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSJXRmm>; Thu, 24 Oct 2002 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265571AbSJXRmm>; Thu, 24 Oct 2002 13:42:42 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:17899 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S265570AbSJXRml>; Thu, 24 Oct 2002 13:42:41 -0400
From: Matthias Welk <matthias.welk@fokus.gmd.de>
Organization: FhG-FOKUS
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Thu, 24 Oct 2002 19:48:38 +0200
User-Agent: KMail/1.4.7
Cc: arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com>
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210241948.38490.matthias.welk@fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 October 2002 19:15, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations
> instead of prefetch.
>
> http://208.15.46.63/events/gdc2002.htm
>
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,
> chipset and memory type?
>
> Please run 2 or 3 times.
>
> --
>     Manfred

Running on an Athlon XP2000+, ASUS A7V333, 768MB DDR2100:

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 18132 cycles per page
copy_page function '2.4 non MMX'         took 25200 cycles per page
copy_page function '2.4 MMX fallback'    took 19369 cycles per page
copy_page function '2.4 MMX version'     took 18078 cycles per page
copy_page function 'faster_copy'         took 11343 cycles per page
copy_page function 'even_faster'         took 11203 cycles per page
copy_page function 'no_prefetch'         took 7814 cycles per page
1019 [maw] (buruk) /tmp/athlon # athlon_test
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 18081 cycles per page
copy_page function '2.4 non MMX'         took 19487 cycles per page
copy_page function '2.4 MMX fallback'    took 19403 cycles per page
copy_page function '2.4 MMX version'     took 18086 cycles per page
copy_page function 'faster_copy'         took 11372 cycles per page
copy_page function 'even_faster'         took 11183 cycles per page
copy_page function 'no_prefetch'         took 7815 cycles per page
1020 [maw] (buruk) /tmp/athlon # athlon_test
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 18081 cycles per page
copy_page function '2.4 non MMX'         took 19487 cycles per page
copy_page function '2.4 MMX fallback'    took 19453 cycles per page
copy_page function '2.4 MMX version'     took 18063 cycles per page
copy_page function 'faster_copy'         took 11335 cycles per page
copy_page function 'even_faster'         took 11154 cycles per page
copy_page function 'no_prefetch'         took 8332 cycles per page

Greeting, Matthias.
-- 
---------------------------------------------------------------
From: Matthias Welk                   office:  +49-30-3463-7272
      FhG-FOKUS                       mobile:  +49-179- 1144752
      Kaiserin-Augusta-Allee 31       fax   :  +49-30-3463-8672
      10589 Berlin    email : matthias.welk@fokus.fraunhofer.de
---------------------------------------------------------------



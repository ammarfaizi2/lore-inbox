Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWCHQSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWCHQSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWCHQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:18:08 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:62700 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750716AbWCHQSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:18:07 -0500
Message-ID: <440F0396.4050905@comcast.net>
Date: Wed, 08 Mar 2006 11:17:26 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060307)
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sound userspace drivers (fishing for insight)
References: <440E5746.7070003@comcast.net> <Pine.LNX.4.61.0603080939360.9337@tm8103.perex-int.cz>
In-Reply-To: <Pine.LNX.4.61.0603080939360.9337@tm8103.perex-int.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jaroslav Kysela wrote:
> On Tue, 7 Mar 2006, John Richard Moser wrote:
> 
>> In general, transporting sound data in and out of kernel space is a
>> horrid thought.  Consider the latencies, which all real-time audio
>> people will quickly get angry about.  Write sound; context switch; sound
>> in driver; context switch back.  This over and over?  Now we all know
>> better than that.
> 
> Nope. If you have a cache coherent architecture like x86, ALSA mmaps 
> directly the DMA buffer to application and even pointers to this buffer 
> are mmaped, thus there is no content switch when apps are doing r/w and 
> there is "zero data copy". The only contents switch is when apps call
> poll(), but you should do it, otherwise you'll eat all cpu time.
> 

Awesome.  Nice design  :)  I hath learned today and I woke up 10 minutes
ago.

>> into the kernel; with alsa it's written to a /proc interface, which
> 
> Using /proc? Where? I've not noticed it :-)

I thought that was what /proc/asound/card0/ was for?  :)
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRA8DlQs1xW0HCTEFAQKeqg//SunhyEf8o4MGpQkrrWImJJ5HOaYFragk
pgr++6lXTxNTJflpKRO+1iblYCrkakOdLaUn01UZqgaxzquaFEuw9N7bNUpI8Fjn
MzS11rYsttZMpfUyT5PiAbMhkiguvBzVv24wcsWwsg83RsH73OZtGGu9BC8SNrw/
jxaJv+B893R6LVIvhMMbRSYAizAEBqfiatttr64G2wNdQ8Hn58fJjStNTyYHFSWo
EwsZe19xOW3XgTlRb3S12e6pw9kxDM46/hxpceXB0PwqUtq8kbD8I9Jeb838M3qf
XM6+HgXYtSpbJ7zMYVPFI//vo140oHSvK8so0Ifz5NQ561AnqIteDPPKqwJTr02D
BqcDZkrXNYoY3qP3rDnTobMciVJycSF6OJp+GHrDxoieV/kKnzjLbvcA4xYU8LmV
PZv0/zNX2ZulrKpnVE8MitwurXnhEVZ8NG82ie7V3COu3JyNzAx+uvQCjUIRDef3
ne2icJcyY6kOuWFL0+FslCW1DwyNt9169PEzvJf5Ns590vEwmaxH9u5GfMsjmPHC
jmh6zmxNyqSJ05XpWGAeM3iPVgeD0aTqi5dnbXIB7AUF/hmhoCf3co7rQ+y7404g
YR7z0vaoK551wCJbkSLa4lnl7oo6lpt8LdS12wIx0c5RGwICTHzCG9uCfAZk+RqX
TedLwHW7cfQ=
=BSFO
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313224AbSDDQMW>; Thu, 4 Apr 2002 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313225AbSDDQMM>; Thu, 4 Apr 2002 11:12:12 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:32698 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S313224AbSDDQLy>;
	Thu, 4 Apr 2002 11:11:54 -0500
Message-Id: <5.1.0.14.2.20020404164546.01f41b80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 04 Apr 2002 17:11:20 +0100
To: Rik van Riel <riel@conectiva.com.br>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Cc: Ingo Molnar <mingo@redhat.com>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0204041217290.18660-100000@imladris.surriel
 .com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:21 04/04/02, Rik van Riel wrote:

>Absolutely agreed.  I've already seen it happen a few times that
>a user needed _2_ binary-only modules, modules which weren't even
>available for the same kernel version.
>
>As it stands right now it is IMPOSSIBLE to support binary only
>drivers and I can only see two ways out of this situation:
>
>(1) don't allow binary only modules at all
>
>(2) have a stable ABI for binary only modules and don't allow
>     these binary only modules to use other symbols, so people
>     in need of binary only modules won't be locked to one
>     particular version of the kernel (or have two binary only
>     modules locked to _different_ versions of the kernel)

Both or these aren't really practical once you think it through. Don't 
forget that each binary module can be wrapped by an GPL-module which the 
kernel cannot do anything at all about and the kernel would never even know 
a binary only module was loaded because the GPL module does it. There is no 
such thing as security... This kind of thing is already in use by at least 
two companies I know of (i.e. using open sourced glue modules to binary 
only code) so it is not just a theory I am making up...

Just my 2p.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


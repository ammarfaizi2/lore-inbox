Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVASVDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVASVDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVASVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:03:05 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48531 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261895AbVASVC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:02:56 -0500
Message-ID: <41EECB0A.9060403@comcast.net>
Date: Wed, 19 Jan 2005 16:03:06 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org> <41EEABEF.5000503@comcast.net> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>            <41EEBF15.9050700@comcast.net> <200501192042.j0JKgPTW024711@turing-police.cc.vt.edu>
In-Reply-To: <200501192042.j0JKgPTW024711@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Wed, 19 Jan 2005 15:12:05 EST, John Richard Moser said:
> 
> 
>>>And why were they merged?  Because they showed up in 4-8K chunks.
> 
> 
>>so you want 90-200 split out patches for GrSecurity?
> 
> 
> Even better would be a 30-40 patch train for PaX, a 10-15 patch train
> for the other randomization stuff in grsecurity (pid, port number, all
> the rest of those), a 50-60 patch train for the RBAC stuff, and so on.
> 

RBAC first.  Some of the other stuff relies on the RBAC system, I'm
told.  Not sure what.

> Keep in mind that properly segmented, *parts* of grsecurity have at least
> a fighting chance - the fact that (for instance) mainline may reject the
> way RBAC is implemented because it's not LSM-based doesn't mean that you
> shouldn't at least try to get the PaX stuff in, and the randomization stuff,
> and so on.
> 

I think GrSecurity's RBAC is a bit bigger than LSM can accomodate.

Anyway, I wasn't originally trying to get PaX into mainline in this
discussion; I think this started out with me trying to point out why
things like PaX have to be all-or-nothing.

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7ssKhDd4aOud5P8RAnVtAJ9f4YcAjLOEGkG7NOB7TBqJdnXD5QCfXwyZ
ozuM56ETWpuOAvKUgXkmJrA=
=+Hnj
-----END PGP SIGNATURE-----

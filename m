Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVASTqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVASTqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVASTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:46:34 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34495 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261529AbVASTqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:46:31 -0500
Message-ID: <41EEB920.8050609@comcast.net>
Date: Wed, 19 Jan 2005 14:46:40 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112182838.2aa7eec2.akpm@osdl.org>	 <20050113033542.GC1212@redhat.com>	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>	 <20050113082320.GB18685@infradead.org>	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>	 <1105635662.6031.35.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>	 <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu>	 <41EEA86D.7020108@comcast.net> <1106160943.6310.184.camel@laptopd505.fenrus.org>
In-Reply-To: <1106160943.6310.184.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>>I respect you as a kernel developer as long as you're doing preemption
>>and schedulers; but I honestly think PaX is the better technology, and I
>>think it's important that the best security technology be in place.  
> 
> 
> the difference is not that big and only in tradeoffs. eg pax trades
> virtual address space against protecting a rare occurance (eg where exec
> shield wouldn't work because of a high executable mapping. That really
> doesn't happen in normal programs)
> 

PAGEEXEC uses the same method as Exec Shield, but falls back to kernel
assisted MMU walking when that fails.  This does not split the address
space in half.  Stop pretending SEGMEXEC is the only emulation PaX has.

PaX also allows more finegrained administrative control.

> 
>>On a final note, isn't PaX the only technology trying to apply NX
>>protections to kernel space? 
> 
> 
> Exec Shield does that too but only if your CPU has hardware assist for
> NX (which all current AMD and most current intel cpus do).
> 

Uh, ok.  You've read the code right?  *would rather hear from Ingo*

> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7rkfhDd4aOud5P8RAmvXAKCMADZGBVZx9UVRTfmVCoSBY9ODrgCfVK5s
djLbjG/KmLx8QotWNAqr6Mc=
=Tcjc
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbTBNTus>; Fri, 14 Feb 2003 14:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbTBNTus>; Fri, 14 Feb 2003 14:50:48 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:57625 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267306AbTBNTur>;
	Fri, 14 Feb 2003 14:50:47 -0500
Message-ID: <3E4D4ADF.3070109@mvista.com>
Date: Fri, 14 Feb 2003 14:00:31 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Zwane Mwaikambo <zwane@holomorphy.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net> <3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net> <3E4D3419.1070207@mvista.com> <Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com> <20030214164436.H2092@almesberger.net>
In-Reply-To: <20030214164436.H2092@almesberger.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Werner Almesberger wrote:

|Zwane Mwaikambo wrote:
|
|>I don't think suspending devices is safe at that stage since removing
|>devices and walking lists and freeing memory and disabling devices and...
|>kicks up quite a storm.
|
|
|If you *really* don't want to stop devices, you can use the
|"reserved, non-DMA memory" approach, kexec the kernel that
|records the crash dump, and then do a system-wide reset, or
|such.
|
|But if you don't have that - possibly considerable - amount
|of memory to spare, you don't have much of a choice than to
|stop devices. Of course, crash dumps don't need a neat and
|clean shutdown, so you can avoid all the kfrees, and such.
|
|(So adding a special mode to the power management code may
|be too much overhead. Besides, sometimes, you can just pull
|a reset line, and don't have to do anything even remotely
|related to power management.)

True, I didn't mean the high-level power management code directly.  But the
PCI API defines a suspend operation that could take a special mode for this.
Or maybe a new field in the PCI structure (and equivalent for other 
things, if
there are any).  But the suspend and resume operations should at least give
a good idea where its needed and how to use it.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+TUrdmUvlb4BhfF4RAn2aAJ40Ktn3x6Zygs1RMnAs/HLp5YqtHwCaA3kD
lRNA6aXFagCkjbE87e+DZCw=
=9wf1
-----END PGP SIGNATURE-----



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTBNSNe>; Fri, 14 Feb 2003 13:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTBNSNe>; Fri, 14 Feb 2003 13:13:34 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:48409 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264681AbTBNSNc>;
	Fri, 14 Feb 2003 13:13:32 -0500
Message-ID: <3E4D3419.1070207@mvista.com>
Date: Fri, 14 Feb 2003 12:23:21 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net> <3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>
In-Reply-To: <20030214151001.F2092@almesberger.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Werner Almesberger wrote:

|Corey Minyard wrote:
|
|>Yes, we were talking about temporary stopgaps.
|
|
|Yes, that's what Suparna and Eric were discussing :-)
|
|>But, I had another idea.  What about using power management?  If you
|>suspended everything, would that be good enough.  I looked at a few
|>drivers, and it seemed so.
|
|
|As long as you don't need any form of synchronization to power
|down a device, and if it comes up silent (i.e. no "sleep" mode,
|in which it still has enough power to remember DMA lists and
|such), that would work.
|
|I'd suspect that power management requiries you to synchronize,
|so we're back to square one.

Yes, some do and some don't.  You could define a new state for the 
"suspend" call that says "just shut down with no locks".  But the 
infrastructure is already in the PCI code and others to do a suspend, 
you could use that and take it out of all the CONFIG_PM ifdefs.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+TTQXmUvlb4BhfF4RArOXAJ4o5F7zgV6zZv9jAXBx5za2xvnZUgCfYj9A
byMvWFosxYMN6/0Ibmk7Ors=
=RLPc
-----END PGP SIGNATURE-----



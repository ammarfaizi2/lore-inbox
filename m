Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUIWHWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUIWHWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWHWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:22:53 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:56159 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268305AbUIWHWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:22:39 -0400
From: tabris <tabris@tabris.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: undecoded slave?
Date: Thu, 23 Sep 2004 03:22:29 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, bzolnier@elka.pw.edu.pl
References: <200409222357.39492.tabris@tabris.net> <20040922210240.1d048d3f.akpm@osdl.org>
In-Reply-To: <20040922210240.1d048d3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200409230322.31586.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 September 2004 12:02 am, Andrew Morton wrote:
> tabris <tabris@tabris.net> wrote:
> > Probing IDE interface ide3...
> >  hdg: Maxtor 4D060H3, ATA DISK drive
> >  hdh: Maxtor 4D060H3, ATA DISK drive
> >  ide-probe: ignoring undecoded slave
> >
> >  Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error above
> > seems to be the only [stated] reason why.
>
> Ok, thanks.  Presumably, reverting ide-probe.patch will get you
> going.
	Hmm. k. I'll work that out tomorrow. thanks.
>
> >  back on 2.6.8-rc1-mm1+idefix2 (lba48 FLUSH CACHE bug) for now.
>
> What is idefix2??
	I could look it up, but it was merged into rc2-mm i believe anyway, 
just before I confirmed that it was the correct fix.
	It was just a fix to stop trying to use LBA48 FLUSH CACHE on drive that 
doesn't support LBA48. the symptom was getting a 'failed opcode' error 
in the syslog every 5 seconds.

- -- 
The difference between dogs and cats is that dogs come when they're
called.  Cats take a message and get back to you.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUnm21U5ZaPMbKQcRAovUAJ9j/96YUZjwTh8XIgXT8SG/s80chwCePnW3
/VmwqBWuEUPfltG0AsBsTzg=
=lTa0
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281648AbRK0RID>; Tue, 27 Nov 2001 12:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281663AbRK0RHy>; Tue, 27 Nov 2001 12:07:54 -0500
Received: from aaf16.warszawa.sdi.tpnet.pl ([217.97.85.16]:6416 "HELO
	aaf16.warszawa.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S281648AbRK0RHi>; Tue, 27 Nov 2001 12:07:38 -0500
Date: Tue, 27 Nov 2001 18:06:22 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12 ... 2.4.16, /dev/tty
Message-ID: <20011127180622.B1087@wonko.esi.org.pl>
In-Reply-To: <XFMail.20011127085220.backes@rhrk.uni-kl.de> <Pine.LNX.4.10.10111271558131.20830-100000@ares.sot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10111271558131.20830-100000@ares.sot.com>
User-Agent: Mutt/1.3.23i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 27 November 2001, Yaroslav Popovitch wrote:
> 
> 
> I also tested my 2.4.10-17 for tty bug,it was there.And I found that bug
> exists if I do the full installation of our distributive.
> 
> > Hi,
> > 
> > still having problems (starting with kernel 2.4.12) with
> > the /dev/tty device:
> > 
> > When logging in on the console and trying the "ps" command,
> > is will list  _all_ processes and not only those which are
> > attached to the controlling terminal. This seemed a little
> > bit suspicious.
[snip] 
> > -----------------------------------------------------
> > 
> > The above described problem first appeared with Kernel 2.4.12,
> > I tried the following kernels (now 2.4.16), BUT WITH NO SUCCESS.
> > Kernel 2.4.10 was _not buggy_.
> > 
> > Additionally, the problem does not arise on all my LINUX workstations,
> > but only on some. And it does not depend on the harware platform.
> > And is does not depend on the distribution. Both on RedHat 7.1 ans
> > Redhat 7.2 having the problem.

I believe it's a problem with /bin/login, which has a race condition
preventing it from opening /dev/tty. It is fixed in rawhide, upgrading
util-linux to at least 2.11f-6 solved this for me.
So it's not a kernel issue.

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>

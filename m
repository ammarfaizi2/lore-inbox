Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVGNXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVGNXNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGNXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:05:12 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:26597 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262709AbVGNXEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:04:25 -0400
From: "Bernd Schubert" <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Date: Fri, 15 Jul 2005 01:04:18 +0200
To: FyD <fyd@u-picardie.fr>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel 2.6.11
Message-ID: <20050714230418.GA19114@tc.pci.uni-heidelberg.de>
References: <1121369685.42d6be556505f@webmail.u-picardie.fr> <200507142106.06682.s0348365@sms.ed.ac.uk> <1121378308.42d6e00473669@webmail.u-picardie.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1121378308.42d6e00473669@webmail.u-picardie.fr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Francois,

> > > I have a problem with a program named Gaussian (http://www.gaussian.com)
> > > (versions g98 or g03) and FC 4.0 (default kernel 2.6.11): I am used to take
> > > Gaussian binaries compiled on the RedHat 9.0 version, and used them on FC
> > > 2.0 or FC 3.0. If I try to do so, on FC 4.0. (with the default kernel)
> > > Gaussian stops (both g98 and g03 versions) with the following error
> > > message:

could you please tell me which compiler you used to compile Gaussian?
Its rather probably pgf77 (PGI), but the version is also important. If
it was 5.2, you just ran into bugs we already experienced some time ago.
I also posted a warning about that to the CCL list. On the CCL list I also saw
there were problems with PGI-6.0, but I never bothered to test this
myself, as our gaussian-binaries compiled with PGI-5.1 seem to work
fine. Also, binaries from the PGI compiler are to our experience rather
sensible to the glibc version. I'm not absolutely sure whats causing
that, but somehow I'm under the impression that the PGI-libraries, which all
binaries created with the PGI compiler are linked with, do some odd
optimizations.  So to make sure that its really a kernel issue you should use the 
libc of the compiler system (via LD_LIBRARY_PATH) or compile Gaussian
statically.

> stat64("/home/fyd/0QM_SCR/Gau-3174.inp", 0xbf9db114) = -1 ENOENT (No such file

I'm a bit tired now and maybe I'm interpreting it wrong, but I think you
should use strace -f ...

> rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
> --- SIGCHLD (Child exited) @ 0 (0) ---

Same here.

Cheers,
	Bernd

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de


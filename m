Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUIIUBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUIIUBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUIIT6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:58:52 -0400
Received: from coral.mweb.co.za ([196.2.50.72]:62092 "EHLO coral.mweb.co.za")
	by vger.kernel.org with ESMTP id S264668AbUIITxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:53:52 -0400
Date: Thu, 9 Sep 2004 21:56:11 +0000
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Richard A Nelson <cowboy@debian.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
Message-ID: <20040909215611.47484cd8@localhost>
In-Reply-To: <Pine.LNX.4.58.0409081644150.6248@hygvzn-guhyr.pnirva.bet>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
	<20040908020402.3823a658.akpm@osdl.org>
	<1094635403.1985.12.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
	<Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
	<1094685396.1362.245.camel@krustophenia.net>
	<Pine.LNX.4.58.0409081644150.6248@hygvzn-guhyr.pnirva.bet>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__9_Sep_2004_21_56_11_+0000_ht8y=CCVwNgszoUH"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__9_Sep_2004_21_56_11_+0000_ht8y=CCVwNgszoUH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 8 Sep 2004 16:51:35 -0700 (PDT)
Richard A Nelson <cowboy@debian.org> wrote:

> On Wed, 8 Sep 2004, Lee Revell wrote:

8<

> >
> > Hmm, I have been running this patch for weeks as part of the voluntary
> > preemption patches, and put it through every torture test I can think
> > of, with nary an Oops.  None of the other VP testers have reported
> > problems either.  Maybe this is some interaction between that patch and
> > something else in -mm.
> 
> Interestingly, I notice Zwane had a very similiar oops, posted on the
> 7th: Oops in __journal_clean_checkpoint_list
> He also had preempt enabled...
> 
> I've found upgrading my Debian system using dselect to be a *very* good
> stress test of the filesystem...
> 
> If you have candidates, I'll try to test them - I've typically had no
> problem reproducing the issue :)
> 

Ok it seem I'm not the only one. Ive bee trying to find this for a while. It seems to happen on 2.6.9rc1-mm[24] kernels (I haven't tried mm[13] ). I was only able to capture the Oops this morning (pen and paper) I also have preempt enabled. This only happens on my PII though (Mandrake cooker updates and kernel compiles), my dual opteron has been running this since last night without any problems (gentoo sync and kernel compile), also with preempt 

--Signature=_Thu__9_Sep_2004_21_56_11_+0000_ht8y=CCVwNgszoUH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBQNGC+pvEqv8+FEMRAt7dAJ0Wm9wFF9KD5C4FaR9AdfE4whKFdACfVMOF
ub6bNyGwSHgq0r+mQzAWjOo=
=+mDW
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Sep_2004_21_56_11_+0000_ht8y=CCVwNgszoUH--

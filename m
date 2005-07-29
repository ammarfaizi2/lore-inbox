Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVG2VTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVG2VTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVG2VSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:18:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:60037 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262807AbVG2VQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:16:48 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Fri, 29 Jul 2005 23:19:20 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200507291540.02278.dominik.karall@gmx.net> <20050729112212.62ad0907.akpm@osdl.org>
In-Reply-To: <20050729112212.62ad0907.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1474991.s9AU4f9YKM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507292319.21167.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1474991.s9AU4f9YKM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 July 2005 20:22, Andrew Morton wrote:
> Dominik Karall <dominik.karall@gmx.net> wrote:
> > On Friday 29 July 2005 06:54, Andrew Morton wrote:
> > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > On Tuesday 07 June 2005 13:29, Andrew Morton wrote:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6=
=2E1
> > > > >2-rc 6/2. 6.12-rc6-mm1/
> > > >
> > > > After looking in my dmesg output today, I saw following error with
> > > > 2.6.12-rc6-mm1, maybe it's usefull to you. I don't know when it
> > > > exactly happens, cause I never used mono last time, I just did an
> > > > emerge mono on my gentoo system, maybe this forced the failure.
> > > >
> > > > note: mono[26736] exited with preempt_count 1
> > > > scheduling while atomic: mono/0x10000001/26736
> > > >
> > > > Call Trace:<ffffffff803e13ea>{schedule+122}
> > > > <ffffffff8013197b>{vprintk+635} <ffffffff803e2738>{cond_resched+56}
> > > > <ffffffff80164de3>{unmap_vmas+1587} <ffffffff8016a560>{exit_mmap+12=
8}
> > > > <ffffffff8012e7bf>{mmput+31} <ffffffff80133466>{do_exit+438}
> > > > <ffffffff8013bf25>{__dequeue_signal+501}
> > > >        <ffffffff801340c8>{do_group_exit+280}
> > > > <ffffffff8013e147>{get_signal_to_deliver+1575}
> > > >        <ffffffff8010de92>{do_signal+162}
> > > > <ffffffff8012d1e0>{default_wake_function+0}
> > > >        <ffffffff8010e8e1>{sys_rt_sigreturn+577}
> > > > <ffffffff8010eb3f>{sysret_signal+28}
> > > >        <ffffffff8010ee27>{ptregscall_common+103}
> > >
> > > A couple of people reported this, but all seems to have gone quiet.  =
Is
> > > it fixed in later -mm's?   Is 2.6.13-rc4 running OK?
> > >
> > > Thanks.
> >
> > hi andrew!
> >
> > I'm sorry, but it's not fixed in current 2.6.13-rc3-mm3. I did an emerge
> > mono right now to test it, and I got this one:
> > Jul 29 15:26:37 [kernel] note: mono[11138] exited with preempt_count 1
> > Jul 29 15:26:50 [kernel] file[14627]: segfault at 00002aaaab453000 rip
> > 00002aaaaaf652cf rsp 00007fffffe43b50 error 4
> > Jul 29 15:26:50 [kernel] file[14633]: segfault at 00002aaaab453000 rip
> > 00002aaaaaf652cf rsp 00007fffffcc87a0 error 4
> > Jul 29 15:26:51 [kernel] file[14669]: segfault at 00002aaaab453000 rip
> > 00002aaaaaf652cf rsp 00007fffff905f80 error 4
> >
> > DEBUG_KERNEL/ PREEMPT/ SPINLOCK are enabled, but I didn't get more info
> > about the bug. Did I forget any debug option?
>
> Gee, I don't know how to find this one.  Do you know if the problem is
> specific to -mm?

Tested with 2.6.13-rc4 and it seems to work. Didn't get any error.

So it seems to be -mm related. Do you suspect any patch which could cause t=
he=20
error?

dominik

--nextPart1474991.s9AU4f9YKM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iQCVAwUAQuqdWQvcoSHvsHMnAQJ+8gQAiKIx8y6xzljoV+nwG5M5cOGoLL8+cCSe
G+4Ch+8B5rOPItGiySMwgLQxBgvkeY08bGGkE2xFQ49q20wQzIUVHq25IS3lLMeC
bIOkdlbyAwR9l1cwDByE2Gp6U8x7spprrYwVJXGZyydFJSsuxDy06JewCmPbkB9E
985nS73byr8=
=jaBx
-----END PGP SIGNATURE-----

--nextPart1474991.s9AU4f9YKM--

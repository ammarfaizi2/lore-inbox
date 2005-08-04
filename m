Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVHDWoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVHDWoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVHDWmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:42:05 -0400
Received: from pop.gmx.net ([213.165.64.20]:45473 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262753AbVHDWle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:41:34 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Fri, 5 Aug 2005 00:44:20 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050804124453.177f6834.akpm@osdl.org> <20050804152858.2ef2d72b.akpm@osdl.org>
In-Reply-To: <20050804152858.2ef2d72b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4194036.PE9qYCFXRv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508050044.24278.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4194036.PE9qYCFXRv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 August 2005 00:28, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > On Friday 29 July 2005 23:27, Andrew Morton wrote:
> > > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > > On Friday 29 July 2005 20:22, Andrew Morton wrote:
> > > > > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > > > > On Friday 29 July 2005 06:54, Andrew Morton wrote:
> > > > > > > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > > > > > > On Tuesday 07 June 2005 13:29, Andrew Morton wrote:
> > > > > > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patch=
es
> > > > > > > > > >/2.6/2 .6.1 2-rc 6/2. 6.12-rc6-mm1/
> > > > > > > > >
> > > > > > > > > After looking in my dmesg output today, I saw following
> > > > > > > > > error with 2.6.12-rc6-mm1, maybe it's usefull to you. I
> > > > > > > > > don't know when it exactly happens, cause I never used mo=
no
> > > > > > > > > last time, I just did an emerge mono on my gentoo system,
> > > > > > > > > maybe this forced the failure.
> > > > > > > > >
> > > > > > > > > note: mono[26736] exited with preempt_count 1
> > > > > > > > > scheduling while atomic: mono/0x10000001/26736
> > > > > > > > >
> > > > > > > > > Call Trace:<ffffffff803e13ea>{schedule+122}
> > > > > > > > > <ffffffff8013197b>{vprintk+635}
> > > > > > > > > <ffffffff803e2738>{cond_resched+56}
> > > > > > > > > <ffffffff80164de3>{unmap_vmas+1587}
> > > > > > > > > <ffffffff8016a560>{exit_mmap+128}
> > > > > > > > > <ffffffff8012e7bf>{mmput+31}
> > > > > > > > > <ffffffff80133466>{do_exit+438}
> > > > > > > > > <ffffffff8013bf25>{__dequeue_signal+501}
> > > > > > > > >        <ffffffff801340c8>{do_group_exit+280}
> > > > > > > > > <ffffffff8013e147>{get_signal_to_deliver+1575}
> > > > > > > > >        <ffffffff8010de92>{do_signal+162}
> > > > > > > > > <ffffffff8012d1e0>{default_wake_function+0}
> > > > > > > > >        <ffffffff8010e8e1>{sys_rt_sigreturn+577}
> > > > > > > > > <ffffffff8010eb3f>{sysret_signal+28}
> > > > > > > > >        <ffffffff8010ee27>{ptregscall_common+103}
> > > > > > > >
> > > > > > > > A couple of people reported this, but all seems to have gone
> > > > > > > > quiet. Is it fixed in later -mm's?   Is 2.6.13-rc4 running
> > > > > > > > OK?
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > >
> > > > > > > hi andrew!
> > > > > > >
> > > > > > > I'm sorry, but it's not fixed in current 2.6.13-rc3-mm3. I did
> > > > > > > an emerge mono right now to test it, and I got this one:
> > > > > > > Jul 29 15:26:37 [kernel] note: mono[11138] exited with
> > > > > > > preempt_count 1 Jul 29 15:26:50 [kernel] file[14627]: segfault
> > > > > > > at 00002aaaab453000 rip 00002aaaaaf652cf rsp 00007fffffe43b50
> > > > > > > error 4
> > > > > > > Jul 29 15:26:50 [kernel] file[14633]: segfault at
> > > > > > > 00002aaaab453000 rip 00002aaaaaf652cf rsp 00007fffffcc87a0
> > > > > > > error 4
> > > > > > > Jul 29 15:26:51 [kernel] file[14669]: segfault at
> > > > > > > 00002aaaab453000 rip 00002aaaaaf652cf rsp 00007fffff905f80
> > > > > > > error 4
> > > > > > >
> > > > > > > DEBUG_KERNEL/ PREEMPT/ SPINLOCK are enabled, but I didn't get
> > > > > > > more info about the bug. Did I forget any debug option?
> > > > > >
> > > > > > Gee, I don't know how to find this one.  Do you know if the
> > > > > > problem is specific to -mm?
> > > > >
> > > > > Tested with 2.6.13-rc4 and it seems to work. Didn't get any error.
> > > >
> > > > Great, thanks for that.
> > > >
> > > > > So it seems to be -mm related. Do you suspect any patch which cou=
ld
> > > > > cause the error?
> > > >
> > > > I wouldn't know, sorry.  Possible the scheduler patches, possibly an
> > > > x86_64-specific patch.  Is the problem repeatable?  If so, a binary
> > > > search would only take ten build-n-boots ;)
> > >
> > > Yes, it is repeatable. I tested on lastest -mm about 4 times. Ok, I
> > > will try to find the right patch tomorrow, 10 build-n-boots would end
> > > up in morning ;)
> > >
> > > btw, as the error occured in 2.6.12-rc6-mm1 too, it must be an old
> > > patch which wasn't merged to linus tree till now...hope there aren't a
> > > lot of them :)
> >
> > Any progress on this?  It kinda measn that the whole of the -mm lineup =
is
> > stuck until we can identify the offending patch.  We have a couple of
> > weeks in which to do this but if you can identify the bad patch it'd he=
lp
> > enormously, thanks.
>
> OK, Bartosz Taudul tells me that he's occasionally seeing this on stock
> 2.6.12 (thanks!).  So there's not a lot of point in doing the -mm bisecti=
on
> search.
>
> I think Ingo was planning on coming up with some infrastructure which wou=
ld
> allow us to debug this further.

I'm sorry that I couldn't do the tests earlier, but I had no time this week=
=2E I=20
did some tests now and noticed that the bug only occures when kde is=20
running...weird.
I'm going to continue testing tomorrow after work, exactly in 12 hours ;)

I will let you know if I have any news!

dominik

--nextPart4194036.PE9qYCFXRv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvKaSAvcoSHvsHMnAQJqBQP/SvInIqWWUTtxO6VUwZykwAFx5j5TpHPm
6e54024u5K4GVCnPDO7/u/vPc0qky1lzKbfsnq+S/1/8KmL1PLXoqMPeZtedD/TR
GcKwjyXCze1tZMZr0IVqTuiwPaYtCZ9J0Y6zEtP8ByyrtSogLykIbm1AVh023b6/
xNvYvCmMD7o=
=CCaF
-----END PGP SIGNATURE-----

--nextPart4194036.PE9qYCFXRv--

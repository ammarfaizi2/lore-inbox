Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUJONcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUJONcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUJONbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:31:10 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2258 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267633AbUJON3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:29:21 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Fri, 15 Oct 2004 09:29:18 -0400
To: Frank Phillips <frankalso@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 oops on java
Message-ID: <20041015132918.GA3142@butterfly.hjsoft.com>
References: <20041014210606.GA23179@butterfly.hjsoft.com> <416F39AA.9080608@charter.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <416F39AA.9080608@charter.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2004 at 09:44:58PM -0500, Frank Phillips wrote:
> John M Flinchbaugh wrote:
> >when i try to start jboss 4.0.0 (sun jdk 1.5.0), i get this oops.
> >trying to start the simple shutdown program does the same thing.
> >otherwise, it's debian unstable, 1.4Ghz pentium m, thinkpad r40.
> >Unable to handle kernel paging request at virtual address 00013c1c
> >printing eip:
> >c011cdc4
> >*pde =3D 00000000
> >Oops: 0002 [#1]
> >PREEMPT
> >Modules linked in: ipv6 thermal fan button ac battery snd_intel8x0=20
> >snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd=20
> >soundcore snd_page_alloc cpufreq_userspace cpufreq_powersave=20
> >speedstep_centrino processor ide_cd cdrom evdev psmouse autofs4=20
> >af_packet ntfs agpgart e100 mii ds yenta_socket pcmcia_core rtc
> >CPU: 0
> >EIP: 0060:[<c011cdc4>] Not tainted VLI
> >EFLAGS: 00010082 (2.6.9-rc4-mm1)
> >EIP is at profile_hit+0x24/0x28
> >eax: 00000000 ebx: 000009c9 ecx: 00000000 edx: 00013c1c
> >esi: 00000000 edi: ffffffea ebp: df2c8f94 esp: df2c8f94
> >ds: 007b es: 007b ss: 0068
> >Process java (pid: 2505, threadinfo=3Ddf2c8000 task=3Ddf15e510)
> >Stack: df2c8fbc c0118a9b df15e510 c03bd3e0 00000000 00000082 0000000a=20
> >000009c9
> >00000001 aa170bb0 df2c8000 c010512f 000009c9 00000000 aa170a20 00000001
> >aa170bb0 aa170a20 0000009c 0000007b 0000007b 0000009c b7f50504 00000073
> >Call Trace:
> >[<c0105f1a>] show_stack+0x7a/0x90
> >[<c0106099>] show_registers+0x149/0x1b0
> >[<c010628d>] die+0xdd/0x180
> >[<c01169f1>] do_page_fault+0x2f1/0x60b
> >[<c0105b7d>] error_code+0x2d/0x38
> >[<c0118a9b>] setscheduler+0xab/0x230
> >[<c010512f>] syscall_call+0x7/0xb
> >Code: ec 5d c3 8d 74 26 00 55 8b 0d 6c e6 3d c0 81 ea 28 02 10 c0 a1=20
> >68 e6 3d c0 89 e5 d3 ea 48 39 d0 0f 46 d0 a1 64 e6 3d c0 8d 14 90 <ff>=
=20
> >02 5d c3 51 52 e8 11 94 1a 00 5a 59 e9 ef f9 ff ff 66 4a 0f
> ><6>note: java[2505] exited with preempt_count 2

> This should fix it:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2=
=2E6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch=20
> patch -R -p1 -i optimize-profile-path-slightly.patch

reverting out this patch fixed it for me.  thank you.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBb9CuCGPRljI8080RAjAYAJwMNYG3pHQPaYfDwPMRWsl8OCCyWQCfVg1x
lXarJqYg+PnczOUxw/lQewo=
=WK8d
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbUCVVyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbUCVVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:54:05 -0500
Received: from mx1.actcom.net.il ([192.114.47.13]:54414 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263704AbUCVVxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:53:36 -0500
Date: Mon, 22 Mar 2004 23:53:27 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jos Hulzink <josh@stack.nl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040322215326.GE13042@mulix.org>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org> <200403222232.20994.josh@stack.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8D3PigL67BfDl295"
Content-Disposition: inline
In-Reply-To: <200403222232.20994.josh@stack.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8D3PigL67BfDl295
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2004 at 10:32:20PM +0100, Jos Hulzink wrote:
> On Monday 22 March 2004 21:22, Muli Ben-Yehuda wrote:
> > In my not so humble opinion, throwing OSS away will be a big mistake,
> > as long as there are people willing to maintain it. Keep it there and
> > let the users (or distributions) choose what to use. I've seen
> > multiple bug reports of cards that work with OSS and don't work with
> > ALSA (and vice versa), so keeping both seems the proper thing to
> > do. Personally, I maintain one OSS driver, and fix bugs in others
> > occasionally.
>=20
> Looking at the amount of warnings in the OSS drivers (depricated=20
> check_region), the OSS drivers seem -with all respect for your hard
> work- not so well maintained anymore. I'm willing to fix them all,
> but not if entire OSS is ditched away Real Soon Now (tm).

Here's a log of a 'make allyesconfig', followed by 'make
sound/oss/', with gcc-3.3.2. This is really not too bad, almost
everything is trivial check_region -> request_region conversions. The
great majority of drivers compile just fine, and at least some of them
(those I have the hardware for) definitely work, too ;-) =20

I intend to go through these warnings and fix them, now that I'm aware
of them. If you or anyone else want to collaborate on it,
great. Andrew Morton is taking OSS patches - I sent one on Saturday
night that's in 2.6.5-rc2-mm1 right now.

Cheers,=20
Muli=20

cd /home/muli/kernel/linux-2.5/
make sound/oss/=20
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC      sound/oss/gus_card.o
sound/oss/gus_card.c: In function `probe_gus':
sound/oss/gus_card.c:76: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/gus_card.c:78: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/gus_card.c:93: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/gus_card.c:94: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
  CC      sound/oss/gus_midi.o
  CC      sound/oss/gus_vol.o
  CC      sound/oss/gus_wave.o
  CC      sound/oss/ics2101.o
  CC      sound/oss/pas2_card.o
  CC      sound/oss/pas2_midi.o
  CC      sound/oss/pas2_mixer.o
  CC      sound/oss/pas2_pcm.o
  CC      sound/oss/sb_card.o
  CC      sound/oss/sb_common.o
sound/oss/sb_common.c: In function `sb_dsp_detect':
sound/oss/sb_common.c:523: warning: `check_region' is deprecated (declared =
at include/linux/ioport.h:121)
sound/oss/sb_common.c: In function `probe_sbmpu':
sound/oss/sb_common.c:1224: warning: `check_region' is deprecated (declared=
 at include/linux/ioport.h:121)
  CC      sound/oss/sb_audio.o
  CC      sound/oss/sb_midi.o
  CC      sound/oss/sb_mixer.o
  CC      sound/oss/sb_ess.o
  CC      sound/oss/dev_table.o
  CC      sound/oss/soundcard.o
  CC      sound/oss/sound_syms.o
  CC      sound/oss/audio.o
  CC      sound/oss/audio_syms.o
  CC      sound/oss/dmabuf.o
  CC      sound/oss/midi_syms.o
  CC      sound/oss/midi_synth.o
  CC      sound/oss/midibuf.o
  CC      sound/oss/sequencer.o
  CC      sound/oss/sequencer_syms.o
  CC      sound/oss/sound_timer.o
  CC      sound/oss/sys_timer.o
  LD      sound/oss/sound.o
  CC      sound/oss/cs4232.o
sound/oss/cs4232.c: In function `probe_cs4232':
sound/oss/cs4232.c:141: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
sound/oss/cs4232.c:193: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
  CC      sound/oss/ad1848.o
sound/oss/ad1848.c: In function `ad1848_detect':
sound/oss/ad1848.c:1580: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/ad1848.c: In function `probe_ms_sound':
sound/oss/ad1848.c:2530: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/ad1848.c: At top level:
sound/oss/ad1848.c:2967: warning: `id_table' defined but not used
  CC      sound/oss/aedsp16.o
  CC      sound/oss/pss.o
sound/oss/pss.c: In function `probe_pss':
sound/oss/pss.c:191: warning: `check_region' is deprecated (declared at inc=
lude/linux/ioport.h:121)
sound/oss/pss.c: In function `configure_nonsound_components':
sound/oss/pss.c:640: warning: `check_region' is deprecated (declared at inc=
lude/linux/ioport.h:121)
sound/oss/pss.c: In function `probe_pss_mpu':
sound/oss/pss.c:710: warning: `check_region' is deprecated (declared at inc=
lude/linux/ioport.h:121)
sound/oss/pss.c: In function `probe_pss_mss':
sound/oss/pss.c:1004: warning: `check_region' is deprecated (declared at in=
clude/linux/ioport.h:121)
  CC      sound/oss/mpu401.o
sound/oss/mpu401.c: In function `probe_mpu401':
sound/oss/mpu401.c:1217: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
  CC      sound/oss/trix.o
sound/oss/trix.c: In function `trix_set_wss_port':
sound/oss/trix.c:85: warning: `check_region' is deprecated (declared at inc=
lude/linux/ioport.h:121)
sound/oss/trix.c: In function `probe_trix_wss':
sound/oss/trix.c:147: warning: `check_region' is deprecated (declared at in=
clude/linux/ioport.h:121)
sound/oss/trix.c: In function `probe_trix_sb':
sound/oss/trix.c:292: warning: `check_region' is deprecated (declared at in=
clude/linux/ioport.h:121)
  LD      sound/oss/sb_lib.o
  CC      sound/oss/uart401.o
  CC      sound/oss/opl3sa.o
sound/oss/opl3sa.c: In function `probe_opl3sa_wss':
sound/oss/opl3sa.c:114: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
sound/oss/opl3sa.c:122: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
  CC      sound/oss/sscape.o
sound/oss/sscape.c: In function `detect_ga':
sound/oss/sscape.c:737: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
sound/oss/sscape.c: In function `sscape_pnp_init_hw':
sound/oss/sscape.c:1113: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/sscape.c: In function `detect_sscape_pnp':
sound/oss/sscape.c:1132: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
sound/oss/sscape.c:1137: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
  CC      sound/oss/mad16.o
sound/oss/mad16.c: In function `wss_init':
sound/oss/mad16.c:322: warning: `check_region' is deprecated (declared at i=
nclude/linux/ioport.h:121)
  CC      sound/oss/opl3sa2.o
  LD      sound/oss/pas2.o
  LD      sound/oss/sb.o
  CC      sound/oss/kahlua.o
(							\
    echo 'static unsigned char * maui_os =3D NULL;';	\
    echo 'static int maui_osLen =3D 0;';			\
) > sound/oss/maui_boot.h
  CC      sound/oss/maui.o
sound/oss/maui.c: In function `probe_maui':
sound/oss/maui.c:307: warning: `check_region' is deprecated (declared at in=
clude/linux/ioport.h:121)
  CC      sound/oss/uart6850.o
  LD      sound/oss/gus.o
  CC      sound/oss/adlib_card.o
  CC      sound/oss/opl3.o
  CC      sound/oss/v_midi.o
  CC      sound/oss/sgalaxy.o
sound/oss/sgalaxy.c: In function `probe_sgalaxy':
sound/oss/sgalaxy.c:89: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
sound/oss/sgalaxy.c:97: warning: `check_region' is deprecated (declared at =
include/linux/ioport.h:121)
  CC      sound/oss/ad1816.o
  CC      sound/oss/ad1889.o
sound/oss/ad1889.c: In function `ad1889_ac97_init':
sound/oss/ad1889.c:853: warning: comparison is always false due to limited =
range of data type
  CC      sound/oss/ac97_codec.o
  CC      sound/oss/aci.o
  CC      sound/oss/awe_wave.o
  CC      sound/oss/via82cxxx_audio.o
  CC      sound/oss/ymfpci.o
  CC      sound/oss/nm256_audio.o
  CC      sound/oss/ac97.o
  CC      sound/oss/i810_audio.o
  CC      sound/oss/sonicvibes.o
  CC      sound/oss/cmpci.o
sound/oss/cmpci.c: In function `cm_release_mixdev':
sound/oss/cmpci.c:1465: warning: unused variable `s'
sound/oss/cmpci.c: At top level:
sound/oss/cmpci.c:2865: warning: `cmpci_pci_tbl' defined but not used
  CC      sound/oss/es1370.o
  CC      sound/oss/es1371.o
  CC      sound/oss/esssolo1.o
  CC      sound/oss/cs46xx.o
  CC      sound/oss/maestro.o
  CC      sound/oss/maestro3.o
  CC      sound/oss/trident.o
  CC      sound/oss/rme96xx.o
  CC      sound/oss/btaudio.o
  CC      sound/oss/ali5455.o
  CC      sound/oss/forte.o
  CC      sound/oss/ac97_plugin_ad1980.o
  CC      sound/oss/cs4281/cs4281m.o
  LD      sound/oss/cs4281/cs4281.o
  LD      sound/oss/cs4281/built-in.o
  CC      sound/oss/emu10k1/audio.o
  CC      sound/oss/emu10k1/cardmi.o
  CC      sound/oss/emu10k1/cardmo.o
  CC      sound/oss/emu10k1/cardwi.o
  CC      sound/oss/emu10k1/cardwo.o
  CC      sound/oss/emu10k1/ecard.o
  CC      sound/oss/emu10k1/efxmgr.o
  CC      sound/oss/emu10k1/emuadxmg.o
  CC      sound/oss/emu10k1/hwaccess.o
  CC      sound/oss/emu10k1/irqmgr.o
  CC      sound/oss/emu10k1/main.o
  CC      sound/oss/emu10k1/midi.o
  CC      sound/oss/emu10k1/mixer.o
  CC      sound/oss/emu10k1/passthrough.o
  CC      sound/oss/emu10k1/recmgr.o
  CC      sound/oss/emu10k1/timer.o
  CC      sound/oss/emu10k1/voicemgr.o
  LD      sound/oss/emu10k1/emu10k1.o
  LD      sound/oss/emu10k1/built-in.o
  LD      sound/oss/built-in.o
  CC [M]  sound/oss/wavfront.o
sound/oss/wavfront.c: In function `detect_wavefront':
sound/oss/wavfront.c:2427: warning: `check_region' is deprecated (declared =
at include/linux/ioport.h:121)
sound/oss/wavfront.c: At top level:
sound/oss/wavfront.c:2498: warning: `errno' defined but not used
  CC [M]  sound/oss/wf_midi.o
sound/oss/wf_midi.c: In function `detect_wf_mpu':
sound/oss/wf_midi.c:788: warning: `check_region' is deprecated (declared at=
 include/linux/ioport.h:121)
  CC [M]  sound/oss/yss225.o
  LD [M]  sound/oss/wavefront.o
  CC [M]  sound/oss/msnd.o
sound/oss/msnd.c: In function `msnd_register':
sound/oss/msnd.c:63: warning: `MOD_INC_USE_COUNT' is deprecated (declared a=
t include/linux/module.h:515)
sound/oss/msnd.c: In function `msnd_unregister':
sound/oss/msnd.c:84: warning: `MOD_DEC_USE_COUNT' is deprecated (declared a=
t include/linux/module.h:527)
  CC [M]  sound/oss/msnd_classic.o
In file included from sound/oss/msnd_classic.c:3:
sound/oss/msnd_pinnacle.c: In function `probe_multisound':
sound/oss/msnd_pinnacle.c:1123: warning: `check_region' is deprecated (decl=
ared at include/linux/ioport.h:121)
  CC [M]  sound/oss/msnd_pinnacle.o
sound/oss/msnd_pinnacle.c: In function `probe_multisound':
sound/oss/msnd_pinnacle.c:1123: warning: `check_region' is deprecated (decl=
ared at include/linux/ioport.h:121)
sound/oss/msnd_pinnacle.c: In function `msnd_init':
sound/oss/msnd_pinnacle.c:1811: warning: `check_region' is deprecated (decl=
ared at include/linux/ioport.h:121)

Compilation finished at Mon Mar 22 23:48:37

--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--8D3PigL67BfDl295
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX2BWKRs727/VN8sRAti6AJ0e4hBcpq4OHXfDGBgFmGyp1UCw3QCgruta
yoxoewJszfVOPy3g94GGToc=
=okvq
-----END PGP SIGNATURE-----

--8D3PigL67BfDl295--

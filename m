Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUIHQDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUIHQDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIHQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:03:00 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:38831 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268092AbUIHQAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:00:42 -0400
Date: Wed, 8 Sep 2004 17:59:31 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -bk15 oops on mounting cdrom
Message-ID: <20040908155931.GB2726@thundrix.ch>
References: <413F2935.4020009@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <413F2935.4020009@blueyonder.co.uk>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 08, 2004 at 04:45:57PM +0100, Sid Boyce wrote:
> Modules linked in: nls_iso8859_1 nvidia parport_pc lp parport sg st sd_mod sr_mod scsi_mod thermal snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss sk98lin snd_intel8x0 processor ub usblp fan usbhid snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu 401_uart snd_rawmidi snd_seq_device snd button ipv6 soundcore ohci1394 ieee1394 ehci_hcd nvidia_agp agpgart ohci_hcd evdev usbcore forcedeth vfat fat dm_mod
> 0060:[cache_free_debugcheck+385/640]    Tainted: P   VLI

You  may  want  to  reproduce  that  bug  without  the  nvidia  module
loaded. This doesn't sound like  much, but I even had strange problems
after registering a simple webcam to the kernel which kept it crashing
while accessing  data structures that  have clearly been  there before
(but  yet it  claimed that  the  memory address  wasn't assigned).  It
turned  out that my  customer had  the NVidia  module loaded.  Once he
unloaded it, everything was running fine.

So please consider  a clean boot without ever  loading nvidia, and try
to reproduce the bug.

			    Tonnerre

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPyxi/4bL7ovhw40RAqvSAJ4jFePH+WMyimjsc0QLanz9Z/fx+QCfYfuU
L3+GOqRQROGI+jk7ieZ61nU=
=VXfd
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

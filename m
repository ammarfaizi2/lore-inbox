Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTHCEQC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 00:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270359AbTHCEQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 00:16:02 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:40902 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S270322AbTHCEPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 00:15:53 -0400
Date: Sun, 03 Aug 2003 16:15:41 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 USB Audio issue
Message-ID: <52400000.1059884141@ijir>
X-Mailer: Mulberry/3.1.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========1856859384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1856859384==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dell Inspiron 8000 (P3, 900MHz), 2.6.0-test2-O12int, ALSA.

BTW, the interactivity is excellent.

The only problem I have so far observed is this, while trying to use an=20
Edirol UA-1 USB audio interface via the OSS compatibility.  No sound came=20
out.

Aug  3 16:09:05 ijir kernel: spurious 8259A interrupt: IRQ15.
Aug  3 16:09:31 ijir kernel: bad: scheduling while atomic!
Aug  3 16:09:31 ijir kernel: Call Trace:
Aug  3 16:09:31 ijir kernel:  [<c011bc0e>] schedule+0x48e/0x4a0
Aug  3 16:09:31 ijir kernel:  [<c012747f>] schedule_timeout+0x5f/0xc0
Aug  3 16:09:31 ijir kernel:  [<c0127410>] process_timeout+0x0/0x10
Aug  3 16:09:31 ijir kernel:  [<e0839d57>] usb_start_wait_urb+0xb7/0x1a0=20
[usbcor
e]
Aug  3 16:09:31 ijir kernel:  [<c011bc70>] default_wake_function+0x0/0x30
Aug  3 16:09:31 ijir kernel:  [<e0839eab>]=20
usb_internal_control_msg+0x6b/0x80 [u
sbcore]
Aug  3 16:09:31 ijir kernel:  [<e0839f5c>] usb_control_msg+0x9c/0xb0=20
[usbcore]
Aug  3 16:09:31 ijir kernel:  [<e083aa6d>] usb_set_interface+0xbd/0x230=20
[usbcore
]
Aug  3 16:09:31 ijir kernel:  [<e08394f0>] hcd_endpoint_disable+0x0/0x1a0=20
[usbco
re]
Aug  3 16:09:31 ijir kernel:  [<e0b08411>] set_format+0xc1/0x2b0=20
[snd_usb_audio]
Aug  3 16:09:31 ijir kernel:  [<e0b08664>] snd_usb_pcm_prepare+0x34/0x50=20
[snd_us
b_audio]
Aug  3 16:09:31 ijir kernel:  [<e0aaea14>] snd_pcm_do_prepare+0x14/0x40=20
[snd_pcm
]
Aug  3 16:09:31 ijir kernel:  [<e0aade49>] snd_pcm_action_single+0x39/0x70=20
[snd_
pcm]
Aug  3 16:09:31 ijir kernel:  [<e0aadf98>]=20
snd_pcm_action_lock_irq+0x98/0xa0 [sn
d_pcm]
Aug  3 16:09:31 ijir kernel:  [<e0aaead1>] snd_pcm_prepare+0x61/0x80=20
[snd_pcm]
Aug  3 16:09:31 ijir kernel:  [<e0ab140e>]=20
snd_pcm_playback_ioctl1+0x5e/0x440 [s
nd_pcm]
Aug  3 16:09:31 ijir kernel:  [<c016a854>] poll_freewait+0x44/0x50
Aug  3 16:09:31 ijir kernel:  [<c016abe8>] do_select+0x1c8/0x2f0
Aug  3 16:09:31 ijir kernel:  [<e0ab1c88>]=20
snd_pcm_kernel_playback_ioctl+0x38/0x
50 [snd_pcm]
Aug  3 16:09:31 ijir kernel:  [<e0ae4fd6>] snd_pcm_oss_prepare+0x26/0x50=20
[snd_pc
m_oss]
Aug  3 16:09:31 ijir kernel:  [<e0ae5048>] snd_pcm_oss_make_ready+0x48/0x70 =

[snd
_pcm_oss]
Aug  3 16:09:31 ijir kernel:  [<e0ae551f>] snd_pcm_oss_write1+0x3f/0x1e0=20
[snd_pc
m_oss]
Aug  3 16:09:31 ijir kernel:  [<c016afae>] sys_select+0x26e/0x560
Aug  3 16:09:31 ijir kernel:  [<e0ae7923>] snd_pcm_oss_write+0x43/0x60=20
[snd_pcm_
oss]
Aug  3 16:09:31 ijir kernel:  [<c01579be>] vfs_write+0xbe/0x130
Aug  3 16:09:31 ijir kernel:  [<c0157ae2>] sys_write+0x42/0x70
Aug  3 16:09:31 ijir kernel:  [<c010b359>] sysenter_past_esp+0x52/0x71
Aug  3 16:09:31 ijir kernel:
Aug  3 16:09:31 ijir kernel: cannot submit datapipe for urb 0, err =3D -22

--==========1856859384==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/LIx1HamGxvX4LwIRAoudAKCVIHJZu+SzMHAjJ0dl4eRMelnqHwCg23gA
xQ1tPU789JxPzWSYsmATkZE=
=vgtL
-----END PGP SIGNATURE-----

--==========1856859384==========--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUFUMlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUFUMlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUFUMlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:41:19 -0400
Received: from [24.178.100.94] ([24.178.100.94]:3718 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S266209AbUFUMlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:41:13 -0400
Date: Mon, 21 Jun 2004 08:40:52 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [Robert.L.Harris@rdlg.net: 2.6.6 and Philips web cam]
Message-ID: <20040621124052.GI871@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjJwPjbdn5RfZuWK"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PjJwPjbdn5RfZuWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I sent this to the owner of the PWCX drivers and no-answer so I'm hoping
someone here might have an idea.  Yes, I tried using the 2.6.4 kernel
with the exaxt same results as the 2.6.7 kernel (output below is from
2.6.7).


------------

I just got a new machine and it's doing the same thing so I figure it's
not hardware.  Basically when I run camstream it complains about an IO
error and blows out.  Here's the console output of camstream:

CCamWindow::CCamWindow()
CWebCamViewer::CWebCamViewer(0x80d8ee8, 640x480)
CVideoDevice::Init()
Using mmap(), VMBuf.size =3D 921600
Trying to find video options for Logitech QuickCam Zoom:/dev/video0
searching OV511 USB Camera
searching Logitech QuickCam Zoom
CSnapshotSettingsDlg::CSnapshotSettingsDlg(...)
CVideoSettingsDlg::SizeChanged(160x120)
CVideoSettingsDlg::FramerateChanged(10)
Philips webcam detected, enabling extensions
VIDIOCPWCSSHUTTER: Connection timed out
CCamPanel::SetSize(160x120)
CCamPanel::SetImageSize(160x120)
CCamPanel::SetVisibleSize(160x120)
CVideoDevice::SetSize(640, 480)
CVideoDevice::MSync() ioctl: Invalid argument
CCamPanel::SetSize(640x480)
CCamPanel::SetImageSize(640x480)
CCamPanel::SetVisibleSize(640x480)
CWebCamViewer::DeviceChangedSize(640x480)
RecalcTotalViewSize: resize viewport(640x480)
CCamPanel::SetSize(640x480)
CCamPanel::SetImageSize(640x480)
CCamPanel::SetVisibleSize(640x480)
RecalcTotalViewSize: resize viewport(640x480)
EnableRGB: +
CVideoDevice::SetPalette picked palette 15 [yuv420p]
CVideoDevice::CreateImagesRGB()
 allocating space for RGB
CVideoDevice::StartCapture() go!
CVideoDevice::MCapture() ioctl: Device or resource busy
CVideoDevice::MSync() ioctl: Input/output error
CVideoDevice::LoadImage() Error loading image; errorcode=3D-5

EnableRGB: -
CVideoDevice::ResetImagesRGB()
 freeing memory
CVideoDevice::SetPalette picked palette 0 []
CVideoDevice::StopCapture() halt!
CVideoDevice::MSync() ioctl: Input/output error
CWebCamViewer::~CWebCamViewer()
CWebCamViewer::StopTimeSnap()
CWebCamViewer::StopFTP()
CVideoDevice::MSync() ioctl: Input/output error
CCamWindow::~CCamWindow()


{0}:/home/nomad>lsmod | grep -i pwc
pwcx                   91648  0=20
pwc                    53360  1 pwcx
videodev               10368  1 pwc

{0}:/home/nomad>lsusb
Bus 005 Device 001: ID 0000:0000 =20
Bus 004 Device 001: ID 0000:0000 =20
Bus 003 Device 004: ID 046d:08b4 Logitech, Inc.=20
Bus 003 Device 003: ID 0451:2046 Texas Instruments, Inc. TUSB2046 Hub
Bus 003 Device 001: ID 0000:0000 =20
Bus 002 Device 003: ID 046d:c401 Logitech, Inc. TrackMan Marble Wheel
Bus 002 Device 001: ID 0000:0000 =20
Bus 001 Device 001: ID 0000:0000 =20

dmesg:
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc Too many ISOC errors, bailing out.
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc Too many ISOC errors, bailing out.
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc Too many ISOC errors, bailing out.
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc Too many ISOC errors, bailing out.
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc pwc_isoc_handler() called with status -75 [Babble (bad cable?)].
pwc set_video_mode(640x480 @ 10, palette 15).
pwc decode_size =3D 5.
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
pwc Frame buffer overflow (flen =3D 773, frame_total_size =3D 76812).
(repeated ALOT)

{0}:/home/nomad>modprobe pwc

root@vampire
{0}:/home/nomad>dmesg
pwc Philips webcam module version 9.0-BETA-2 loaded.
pwc Supports Philips PCA645/646, PCVC675/680/690,
PCVC720[40]/730/740/750 & PCVC830/840.
pwc Also supports the Askey VC010, various Logitech Quickcams, Samsung
MPC-C10 and MPC-C30,
pwc the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite
VCS-UC300 and VCS-UM100.
pwc Logitech QuickCam Zoom (new model) USB webcam detected.
pwc Registered as /dev/video0.
usbcore: registered new driver Philips webcam

{0}:/home/nomad>modprobe pwcx

{0}:/home/nomad>dmesg
pwc Philips webcam decompressor routines version 9.0-BETA-2
pwc Supports all cameras supported by the main module (pwc).
pwc Adding decompressor for model 645.
pwc Adding decompressor for model 646.
pwc Adding decompressor for model 675.
pwc Adding decompressor for model 680.
pwc Adding decompressor for model 690.
pwc Adding decompressor for model 720.
pwc Adding decompressor for model 730.
pwc Adding decompressor for model 740.
pwc Adding decompressor for model 750.


Any ideas?

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

With Dreams To Be A King First One Should Be A Man
					- Manowar


--PjJwPjbdn5RfZuWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1tdU8+1vMONE2jsRAhc1AKC/GI7IX/7aJLM11Gv6bFHX8DnX7wCeIN5W
7T0Tigcl/3HIgqUdBRTKkJA=
=w1Gk
-----END PGP SIGNATURE-----

--PjJwPjbdn5RfZuWK--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbWBNOQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbWBNOQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWBNOQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:16:04 -0500
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:33438
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030578AbWBNOQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:16:03 -0500
From: hackmiester / Hunter Fuller <hackmiester@hackmiester.com>
Reply-To: hackmiester@hackmiester.com
Organization: hackmiester.com, Ltd.
To: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 08:15:41 -0600
User-Agent: KMail/1.8
References: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
X-Face: #pm4uI.4%U/S1i<i'(UPkahbf^inZ;WOH{EKM,<n/P;R5m8#`2&`HN`hB;ht_>oJYRGD3o
	)AM
MIME-Version: 1.0
Message-Id: <200602140815.44008.hackmiester@hackmiester.com>
Content-Type: multipart/signed;
  boundary="nextPart1139930704.RnJvuABIDx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1139930704.RnJvuABIDx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 12 February 2006 20:19, Alan Stern wrote:
> On Sun, 12 Feb 2006, Phillip Susi wrote:
> > Alan Stern wrote:
> > > Both of you are missing an important difference between Suspend-to-RAM
> > > and Suspend-to-Disk.
> > >
> > > Suspend-to-RAM is a true suspend operation, in that the hardware's
> > > state is maintained _in the hardware_.  External buses like USB will
> > > retain suspend power, for instance (assuming the motherboard supports
> > > it; some don't).
> > >
> > > Suspend-to-Disk, by contrast, is _not_ a true suspend.  It can more
> > > accurately be described as checkpoint-and-turn-off.  Hardware state is
> > > not maintained.  (Some systems may support a special ACPI state that
> > > does maintain suspend power to external buses during shutdown, I forg=
et
> > > what it's called.  And I down't know whether swsusp uses this state.)
> >
> > I would disagree.  The only difference between the two is WHERE the
> > state is maintained - ram vs. disk.  I won't really argue it though,
> > because it's just semantics -- call it whatever you want.
>
> It's not just semantics.  There's a real difference between maintaining
> state in the hardware and maintaining it somewhere else.  The biggest
> difference is that if the hardware retains suspend power, it is able to
> detect disconnections.  When the system resumes, it _knows_ whether a
> device was attached the entire time, as opposed to being unplugged and
> replugged (or possibly a different device plugged in!) while the system
> was asleep.  If the hardware is down completely, there is no way of
> telling for certain whether a device attached to some port is the same one
> that was there when the system got suspended.
>
> Another difference is the possibility of remote wakeup.  Clearly it can't
> happen when there's no power available.

Well... sort of. I know that my notebook can be brought up over LAN when it=
 is=20
off - suspended to disk or otherwise.
>
> > > So for example, let's say you have a filesystem mounted on a USB flash
> > > or disk drive.  With Suspend-to-RAM, there's a very good chance that
> > > the connection and filesystem will still be intact when you resume.=20
> > > With Suspend-to-Disk, the USB connection will terminate when the
> > > computer shuts down.  When you resume, the device will be gone and yo=
ur
> > > filesystem will be screwed.
> >
> > This is not true.  The USB bus is shut down either way, and provided
> > that you have not unplugged the disk, nothing will be screwed when you
> > resume from disk or ram.
>
> Have you actually tried it?  I have.
>
> In any case, it is undeniably true that if the bus is shut down then all
> the USB connections are lost.  When you resume it will be the same as if
> you had unplugged all the USB devices and then replugged them.  Not a good
> thing to do when they contain mounted filesystems; all the memory mappings
> are invalidated.

It all depends on the machine I guess. Mine keeps even the CD drive running=
=20
when it's off!
>
> (Bear in mind that whether a USB bus gets shut down depends on the
> motherboard; some supply suspend power and some don't.  It depends on the
> USB controller too; some support low-power states other than "completely
> off" and others don't.)
>
> Alan Stern
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D-hackmiester
If you can read this, you don't need glasses.

--nextPart1139930704.RnJvuABIDx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD8eYP3ApzN91C7BcRAiiwAJ47jd9Mr51z7Aoi+2VCfyNJsG4nlACfbvFW
kNNU40Z/KXm1cdpVyF7ly0U=
=DUmM
-----END PGP SIGNATURE-----

--nextPart1139930704.RnJvuABIDx--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVBOFj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVBOFj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 00:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBOFj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 00:39:56 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4551 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261631AbVBOFjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 00:39:52 -0500
Message-ID: <42118B19.8000106@t-online.de>
Date: Tue, 15 Feb 2005 06:39:37 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
References: <20050211004033.GA26624@suse.de> <420D1050.3080405@t-online.de> <20050211210114.GA21314@suse.de> <420DBEBE.1060008@t-online.de> <20050214223613.GB13110@suse.de>
In-Reply-To: <20050214223613.GB13110@suse.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20140004746626BE6CBEC97A"
X-ID: XRxHm4ZHreYx3S296U+lxguGSI8715BfilQGSMJ8cj6BsLBTeQ1hZR
X-TOI-MSGID: 7b01d8c5-abf2-4059-a96c-e37f2fa4d9f5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20140004746626BE6CBEC97A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Sat, Feb 12, 2005 at 09:30:54AM +0100, Harald Dunkel wrote:
>
>>
>>If it is not possible to use klibc together with a non-Linux
>>system (e.g. FreeBSD or Mach), then I would suggest to make
>>klibc an optional kernel patch and drop it from udev and
>>hotplug.
>
>
> But it is not possible to use udev or hotplug-ng on a non-Linux system,
> right?
>

Thats not the point. The point is to remove the copy of the
klibc sources from packages like udev and hotplug-ng and
to use the existing klibc sources or binaries on the target
system instead. Just to keep it modular.

> As far as "optional kernel patch"?  What do you mean?  People are
> working on adding klibc to the main kernel tree, nothing optional about
> that.
>

I do not know the internals of klibc that much. Is it possible
to use klibc on non-Linux systems, e.g. on Mach or FreeBSD?
Maybe by adding some #ifdefs to klibc's kernel interface?

If yes, then making klibc an integrated part of the Linux
kernel source tree and dropping the independent development
tree would be a restriction to the use of klibc.


AFAIK the plan for initramfs is to move as much functionality
as possible from kernel to user space. Why not do the same
thing for the sources? Everything that is supposed to be run
in user space could be removed from the kernel source tree
and managed seperately, either in a set of userspace modules
like klibc, hotplug, udev, initramfs, etc., or in a monolithic
"userspace-tools" source tree.

Surely klibc belongs to the user space.


Regards

Harri

--------------enig20140004746626BE6CBEC97A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCEYsdUTlbRTxpHjcRAoD5AJ45QfdZ33HEPvWDfrXvkwl6J023XgCdGtdp
KmK692yen23aFbD88j2kvCk=
=jV9Y
-----END PGP SIGNATURE-----

--------------enig20140004746626BE6CBEC97A--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277359AbRJELvL>; Fri, 5 Oct 2001 07:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277362AbRJELvA>; Fri, 5 Oct 2001 07:51:00 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:22592 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277359AbRJELus>; Fri, 5 Oct 2001 07:50:48 -0400
Date: Fri, 5 Oct 2001 12:51:16 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: User-level USB device drivers, and permissions
Message-ID: <20011005125116.K7197@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a question regarding user-level USB device drivers.  The
project I'm thinking about is gphoto2.  I'm posting it here because at
least part of the solution lies in usbdevfs I think.

The problem is this:

How can a user-level USB device driver do its job while running as a
non-root 'console' user, with minimal (preferrably no) intervention
from the sysadmin?

By 'console' user, I am talking about the users that pam_console will
recognise as being on the console.

The closest solution at the moment seems to be: mount /proc/bus/usb
group-writable and group-owned by 'usb', and add users that can use
USB devices to group 'usb'.  This has the following problems:

- sysadmin needs to add any potential console users to the 'usb' group
  first,
- those users are then in the usb group even when not at the console.

An idea in my head is to have a pam module that, for console users,
mounts -tusbdevfs none /somewhere/usb-bus/$LOGNAME with user ownership
on login and dismounts it on logout, but I don't know if that is
feasible.

Does anyone know if this problem has already been solved, or else can
they think of a solution?

Thanks,
Tim.
*/

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7vZ60yaXy9qA00+cRAst4AJ9zyT6dpvRtN59zlpWXa6nGqCjmAACghSu6
stYJO0k1PL+BXgH5y0poSQU=
=8Ieh
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--

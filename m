Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJ3RXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbTJ3RXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:23:41 -0500
Received: from northuist.CNS.CWRU.Edu ([129.22.104.60]:42470 "EHLO
	ims-msg.TIS.CWRU.Edu") by vger.kernel.org with ESMTP
	id S262672AbTJ3RXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:23:39 -0500
Date: Thu, 30 Oct 2003 17:12:35 +0000
From: Dan Bernard <djb29@cwru.edu>
Subject: Re: kernel: i8253 counting too high! resetting..
In-reply-to: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com>
To: CN <cnliou9@fastmail.fm>
Cc: linux-kernel@vger.kernel.org
Message-id: <20031030171235.GA59683@teraz.cwru.edu>
MIME-version: 1.0
X-Mailer: Mutt 1.4.1i-JA.1 [JP] (FreeBSD i386)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=x+6KMIRAuhnl3hBn
Content-disposition: inline
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20031028 2350, CN wrote:
> entries in syslog from kernel 2.4.22 upgraded from Debian woody (gcc
> 2.95.4) running on AMD K6II 450MHz with 64MB RAM. I don't have such
> problem in kernel 2.4.20 upgraded from Slackware (gcc 2.95.3) running on
> another box with the identical CPU and main board (but with 192MB RAM).
> Does this message hurt anything?

Can you please provide additional details about your hardware?
What kind of main board are you using, and what southbridge?
What is the reported latency of your IDE interface?

These messages always appear on virtual consoles of one particular machine.
These messages are kernel warnings regarding some kind of locking/timing
issue with a certain bridge controller, as far as I know.  I suspect one
of the ALi chips on my TransMeta TM5800 (ALi M1535 integrated southbridge)
to be the culprit, likely the M1533 PCI-ISA bridge or M5229 IDE controller,
which claims to be bridged with an ALi M7101 PMU, although I have a number
of other unidentified ALi chips on that board, including an ALi M5819P,
which I'm guessing is some kind of timing chip that doesn't register
with the kernel.

Details aside, this message is an increasingly common problem.  Simply
do a Google search for i8253 and you'll see what I mean.  As far as I
can tell, since my LFS system running 2.4.21-xfs on this hardware has
been up for over 63 days and counting, these reset messages are not
harmful.  They are only a bit of a nuisance as they constantly overflow
my /proc/kmsg, rendering dmesg rather useless.  Anyway, I would be very
interested to see what other hardware on which this may be seen.

Regards,
Dan Bernard


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (FreeBSD)

iD8DBQE/oUaDkv1ulvlcHpMRAvf6AJ92gEJkxyKd6U2P0u5zUUM287SNKgCeJ6oM
84vlLIPft/q81c2a1mbHyTk=
=V+4Q
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUAHOas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbUAHOas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:30:48 -0500
Received: from h80ad37a4.dhcp.vt.edu ([128.173.55.164]:15232 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263596AbUAHOaq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:30:46 -0500
Message-Id: <200401081430.i08EUVfx005021@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: bert hubert <ahu@ds9a.nl>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: blockfile access patterns logging 
In-Reply-To: Your message of "Thu, 08 Jan 2004 13:00:08 +0100."
             <20040108120008.GA7415@outpost.ds9a.nl> 
From: Valdis.Kletnieks@vt.edu
References: <20040108120008.GA7415@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1370116454P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jan 2004 09:30:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1370116454P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Jan 2004 13:00:08 +0100, bert hubert said:

> For some time I've wanted to log exactly what linux is reading and writing
> from my harddisk - for a variety of reasons. The current reason is that my
> very idle laptop writes to disk every once in a while (or reads, I don't
> know).
> 
> Now, conceptually this should not be very hard, but I'd like to ask your
> thoughts on where I might insert some crude logging? There are lots of
> places that might be better or worse for some reason.
> 
> I'd love to be as close to the physical block device as possible, short of
> rewriting actual IDE drivers.

You probably want to do logging at a higher level.  It's totally useless to find out
that LBA 2234324567 got re-written.  Mapping it to a partition on the disk so
you know it was something on /dev/hda7 is a bit better.  And being able to tell
that somebody updated the atime on /var/log/messages is most informative of all.

The other problem is that unless your laptop is *VERY* idle, you will have a scrolling
problem and buffering issues - so you end up writing to disk to log the buffers and... ;)

--==_Exmh_-1370116454P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE//WmGcC3lWbTT17ARAh/1AJ0eSJQW1L3IQ/qDV4LgoNNLCwXuBQCghq1w
7HSA2JZ9AfWE/SJpfxEJfl4=
=OjhD
-----END PGP SIGNATURE-----

--==_Exmh_-1370116454P--

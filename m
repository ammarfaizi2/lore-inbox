Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTKLW40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 17:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbTKLW40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 17:56:26 -0500
Received: from dialin-212-144-182-177.arcor-ip.net ([212.144.182.177]:384 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261664AbTKLW4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 17:56:24 -0500
Date: Wed, 12 Nov 2003 23:56:24 +0100
From: Thunder Anklin <thunder@keepsake.ch>
To: linux-kernel@vger.kernel.org
Subject: [2.6] VC (keyboard) doesn't clean up its buffers
Message-ID: <20031112225624.GA922@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
X-Location: Dorndorf-Steudnitz, TH (Germany)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

I've  got into  trouble with  the Linux  2.6 keyboard  layer  of Linux
2.6.0-test9* (That is, I've tested the  original as well as BK and the
mm1 and mm2 patches.) The problem is the keyboard buffer.

tty->filp.char_buf is filled correctly by my typings. The buffer state
goes  up,  and  once  I've   typed  255  characters,  of  course  it's
full. *But* the big deal  with the keyboard buffer is usually somebody
who's  reading  out  the  contents  and processing  it,  so  that  the
characters  I typed  are processed.  This is  *not* taking  place. The
buffer just fills up and there we are.

I'm of course trying to solve  that problem on my own (I remember that
last time I've  had a problem no  one even read my email),  but I'd be
glad if you'd give me some additional hints on what to do.

If I  use SysRq, the  whole thing works,  of course, as  SysRqs aren't
read from the input buffer.

(The input is  processed corectly all the way  from the keyboard (PS/2
or USB, doesn't matter, as it  works both ways.) into the buffers. The
up/down events are  handled correctly. The only thing  that's wrong is
that nobody is reading out the buffer afterwards.)

Thanks a lot for every helpful response.

				Thunder

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/srqYygQNIN66kP8RAi7xAJ9hVUlDBv5kvn8eyOe8AVZPbTnJ+QCbBGpo
SBEwq+YcabFnt4d73APIFZw=
=FSne
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

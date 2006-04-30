Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWD3R1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWD3R1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWD3R1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:27:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:20664 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751126AbWD3R1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:27:21 -0400
X-Authenticated: #2308221
Date: Sun, 30 Apr 2006 19:27:16 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [FYI] whitespace removal
Message-ID: <20060430172716.GC17917@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi there,

while fiddling with some driver development I noticed the disturbing
effect of trailing whitespace while comparing functionally different
versions of a driver. Since even git pukes when it encounters some, I
did
	find -type f | xargs sed -e"s/\(\t\|\ \)*$//" -i
on Linus' current git to estimate the dimension of the mess, and the
resulting diff was 25MB in size. Mebibytes, that is (and yuck, what an
un-word). Granted, for one line that has its whitespace removed we get
roughly eight lines in the diff, so this is mostly bloat.

I ended up sending cleanup patches to the maintainers of the external /
internal repository of that driver respectively, but looking at the size
of this "simple" no-op change, I'd rather leave it to driver or
subsystem maintainers to Do The Right Thing in itty bitty steps.

Not trying to be pedantic here, and even less trying to start a flame
war.

Kind regards,
Chris


--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRFTzc12m8MprmeOlAQKYkRAAuq91Rj018PmM1us1Uug2yHjHE6dAL5l5
lRXng4CeZ4VXR45H9JDfBrMalcVQOSrehvf5ED0qIJcNsvje67kpyK23mpWbyvx8
NAvBscToLvDCrRWv1WvEQCaVfO0v9zows8n1MuNEeib+DEZqDFD7hQB1BK9x98vC
O8hm+JSb8zvhGEJ9IcsmJ6fTJYWQcyLigmLt2BLTFP0mzm5MHN7LIZnPOiceGVGa
CeJWyZunRvH1hNIq4btsQMS4uMZzcwUXW52zgW2e0p0ASUoG0fflQDFkfxWzfMzc
SXya7we/uJPgQHocyFAXmmplQPicN3obNF07pLzvNUQ0XLoBjHWAnXQ5wkOHMo/d
4GecwaQNg2+3GTr9otQPqRFDbipaapS7DhN0BLmBV/GuAmTqkmzcVsIMxIZEGdNZ
SxvjXNOXOTyFVs7uFdpY15e6OaQAOjVP5GqZKFeirZsw/x5tx5ZSk9ohwnr7/eNe
9y4ylJI12nTAUh8GGTBFk/M+zfOXeKKhGTPCLWT50372jvHvEv8VZJkAlTvXvQlw
PIwUbqW8LMASa+yiUAQ8BUN1ZLJ8lcwDVpen5+CneaaUgy09lmNynyQexmicHiG+
E5kVfuHvYBwBPNCBjlM1HNkzDhZG9ZrBfzjSQbwlhd1QhNuK2+VNmHgK0Vi9+iL/
8broUfH9EwQ=
=/oCS
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--


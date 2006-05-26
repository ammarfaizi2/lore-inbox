Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWEZVL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWEZVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWEZVL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:11:57 -0400
Received: from mail.gmx.net ([213.165.64.21]:19663 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751512AbWEZVL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:11:56 -0400
X-Authenticated: #2308221
Date: Fri, 26 May 2006 23:11:40 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Message-ID: <20060526211140.GC16059@hermes.uziel.local>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk> <20060525202917.GB21926@csclub.uwaterloo.ca> <Pine.LNX.4.61.0605261354220.899@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605261354220.899@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On Fri, May 26, 2006 at 01:56:02PM +0200, Jan Engelhardt wrote:
> What a mess. I would prefer to see Linux distributions have
> 127.0.0.1 localhost
> in their /etc/hosts (to have the standard 127.0.0.1<->localhost mapping)=
=20
> and /etc/HOSTNAME contain the hostname, which is=20
> sethostname()d/setdomainname()d by init scripts and gethostname()d by app=
s.

Well I always thought that 127.0.0.1 is localhost, and _only_ localhost,
and the host's real name would rather be mapped to its IP on the real
NIC. Every interface (including local loopback) has a distinct IP;
hostnames are supposed to be resolved to one of these and need to be
somewhat unique on subnets, unless a fqdn is supplied. So here's what I
got, following that scheme:

127.0.0.1     localhost.localdomain    localhost
192.168.x.y   host.domain.tdl          host

Major catch: it presumes you have at least one NIC actually in use. If
lo is the absolute sole interface, one might map every single hostname
to that one as well. Schizophrenia is fun, solitude is gone for good : )

Larger institutions would prefer dynamic stuff like DHCP and DNS anyway,
but for distros' installers intended for home users this might be a
viable solution - never experienced any strangeness with that one so
far.

Just my .02=E2=82=AC, with kind regards
Chris

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHdvC12m8MprmeOlAQL8AQ/9GBgQmFzv/AP676+I8EnRCx1WjpyeUkME
CXW281S96lOWTti/ou7OHs2MYVoSao+CfC+v54VslVnApuAuHn8FDav5o+L/Nfbp
EAiJyNVhoGa6grCt/qcRkg6Fsket9CZ9Wgoao4BS98Xl7NynE1wxpKMSN9Cw2l7U
NyWGGCv5j2Oyop6hfoovcJSM9EOftyrnE1y+l8L34Akb0i+SkffVlazIw8QhT+Zg
8Od/SR35QyeJHHvWJ0ddyykyqI5hvSvqQCK13GxuDVkYHdgQGmi0xBYaHqgyo9vs
SQSeLFl9Did7Lb5XsDmeBmXLHMlULOBT+staJVlyJXkVJhfwQZGOh1GqfyR3WMPp
1hFa18n4qAGG+VtUGn07S2GRS5DhMJL7uDAYJVWPOC3iR8O4NcHWNBS1ijZRCUf7
q2PapoD6rADGlgidIJaCSQFynxCJvhxTdiEUPm2bqzQezpxd8BAp0O8cB0+Jbo5q
daFqi+TWMP/5GXScI1/ovsysLc77q1o5DKAGKIZP+MacqEJnMBjweDq/PlpkW1j7
afT7lOU/9tybUGA0Bumf0okq6VeDbLtxUH0BMdsK1w9eFEReV2EhY0SqtM2nx9WO
kXG96Z41wuOIGBZuqQu/0KR3S4l1OQLuGHxvamUeB07nq4CIjX0Y5YlUOzhhw/qr
ksdPQA14W2E=
=bmq4
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--


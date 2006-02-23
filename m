Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWBWOKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWBWOKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWBWOKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:10:52 -0500
Received: from master.altlinux.org ([62.118.250.235]:5897 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751263AbWBWOKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:10:51 -0500
Date: Thu, 23 Feb 2006 17:10:10 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Git via a proxy server?
Message-Id: <20060223171010.283a9bfe.vsu@altlinux.ru>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F022DD553@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F022DD553@otce2k03.adaptec.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__23_Feb_2006_17_10_10_+0300_e/1Jc4hpGM=VsTOA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__23_Feb_2006_17_10_10_+0300_e/1Jc4hpGM=VsTOA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Feb 2006 10:44:23 -0500 Salyzyn, Mark wrote:

> Rsync protocol for git is not working for some reason when I pick up the
> trees; apparently others share my experience. So I switched to the git
> protocol. I can pick up the trees via git if I am outside Adaptec's
> network, but inside I need to go through the proxy server.

I have successfully used transconnect
(http://sourceforge.net/projects/transconnect) for tunnelling git
protocol through a HTTP proxy (squid in my case) supporting the CONNECT
method.

Git also supports the GIT_PROXY_COMMAND environment variable (or
core.gitproxy config option), through which you can specify a program to
be run instead of connecting to a TCP port - then you can use netcat for
connecting through proxy; however, I have not tried this.

Note: most HTTP proxy servers allow CONNECT method to a very limited
range of ports, and administrators will need to enable the git port
(9418) explicitly.

--Signature=_Thu__23_Feb_2006_17_10_10_+0300_e/1Jc4hpGM=VsTOA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD/cJCW82GfkQfsqIRAqLMAJ99z6eXO9vrDDYPfXG/CPNA5qJmSgCfTMn2
D/1g3F9WPdQQK33V0llIY5c=
=taQH
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Feb_2006_17_10_10_+0300_e/1Jc4hpGM=VsTOA--

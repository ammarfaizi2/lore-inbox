Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbULFT0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbULFT0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbULFT0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:26:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36243 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261623AbULFT0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:26:22 -0500
Message-ID: <41B4B210.1040105@redhat.com>
Date: Mon, 06 Dec 2004 11:25:04 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: "Randy.Dunlap" <rddunlap@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org> <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr> <41B48C9E.6030607@osdl.org> <41B49773.1010006@domdv.de>
In-Reply-To: <41B49773.1010006@domdv.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Steinmetz wrote:

> 63 characters per label (=hostname) as to:

A "label" is only a part of the fqdn:

<domain> ::= <subdomain> | " "

<subdomain> ::= <label> | <subdomain> "." <label>

<label> ::= <letter> [ [ <ldh-str> ] <let-dig> ]


Yes, each label can only have 63 bytes, but the entire fqdn can be
longer, much longer.  And the hostname stored with sethostname() should
be the fqdn of the machine, not just one lalbel (in DNS speak).

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBtLIQ2ijCOnn/RHQRAiqhAJsH2+QD8oI8O+/tRmg/+uHXlGAAIACdF9D1
qh0Lqh7/OCp20LI34eBPE+I=
=DQ59
-----END PGP SIGNATURE-----

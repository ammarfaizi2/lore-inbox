Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUFYKEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUFYKEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266690AbUFYKEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:04:39 -0400
Received: from smtp2.cwidc.net ([154.33.63.112]:41657 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S265960AbUFYKEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:04:23 -0400
Message-ID: <40DBF894.5000306@tequila.co.jp>
Date: Fri, 25 Jun 2004 19:04:04 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.7 and khelper
References: <40DB76F1.9010107@tequila.co.jp> <20040624184749.008358b0.akpm@osdl.org>
In-Reply-To: <20040624184749.008358b0.akpm@osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:

| Strange.  I assume that what's happening is that the children of khelper
| are being created and are dying, and init is somehow seeing this happen.
| Maybe SIGCHLD, probably via wait4().  Perhaps init should be changed
to not
| complain about processes which it did't parent.  But then, that should
| already be the case.
|
|
| Could you please apply the below debug patch, then send us all the
relevant
| syslog output, including the messages from init?

I have applied the patch against a vanilla 2.6.7, but until now i
haven't got any output. But after the next crontab run, I'll see that.
I'll push that later.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2/iUjBz/yQjBxz8RAit0AJ9pt1gKbEfyvTQRQuAjN15Wsj1MugCgr6I+
wqHSBXyxgsCbDaKVHSVIs1I=
=6wlJ
-----END PGP SIGNATURE-----

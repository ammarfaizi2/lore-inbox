Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbULDFZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbULDFZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 00:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbULDFZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 00:25:51 -0500
Received: from main.gmane.org ([80.91.229.2]:42907 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261628AbULDFZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 00:25:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.6.10-rc2] In-kernel swsusp broken
Date: Fri, 03 Dec 2004 21:25:39 -0800
Message-ID: <41B14A53.2070905@triplehelix.org>
References: <419DC24C.9000902@triplehelix.org>	<20041129164112.3d51be93.akpm@osdl.org>	<41B1296C.8060804@triplehelix.org> <20041203195245.29e7ce03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: pavel@ucw.cz
X-Gmane-NNTP-Posting-Host: adsl-68-126-237-170.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <20041203195245.29e7ce03.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
|>Stay tuned.. I might find something!
|
|
| Cool, thanks.  I'll hold my breath ;)

Got it:

http://linux.bkbits.net:8080/linux-2.6/cset@1.2026.53.35

Reverting the bit of this that affects pci-driver.c fixes bk15 for me.
2.6.10-rc2 with this reverted also works.

Anything else you need? Could it be that a certain driver has a bad
suspend function which is causing the hang? I'll try and come up with
some debugging code to figure out where the hang is happening but I
first have to disable PM for my framebuffer without breaking other things.

Hope this helps.

- --
Joshua Kwan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQbFKTaOILr94RG8mAQKBQQ//SGQxQh+EgiVhNUWQQMYWyss8/z+AFrO2
+7Y4TVU0L+CA9C3bYrPKUVXBIVHrASzJXoC6ayFVjxyBozV1gi7lX8PG0i8hGnL2
btoPdXOzDpwM99yyiQoPtkbUh5JLOstf+puX6QUPx9meJjXnrW6vsASuz6EEO/uG
2IKxLBi84eKMiQ4CwBFqHt881AYNfBl81HchzKkTdA3qs5XXdf3cy6z7nvGHOGWO
nJvLBPNP4UzteC7cHqHseAVF9pUctTgwY6wBcsQKXuhVPcl+ITFVGhDMijKif485
WdKSbXVCtxaA/qQPQbLuWhpz4lEzmW0WQa1A4JfsNWCStiO92CVOqAo2wUwxsZgI
zGiV9BipBChnA4GgvwBJgDlhSqwQsTvKGPLZMmAkNwiCyvm9PwiAEh1E1ZH5zpab
Ce4nbp3Z0IWzriPY0UlN/eMBt8sxTInUw2yla/6qdV2Is1oS5gclWC5YACNcapLR
j9OWTDV0JQRD+iM6i3VYYinqTvmochf8yC1CEhyuhl+aFErwYu69ZZESnHG+BEqJ
wna2B+ktDFzPypmzTeYSNfHjbDu8SVVh3gpsZk6zx2/Lw0LJiCSzDeQ5E84RI26W
2kQMQIa1i6UiJae9Z42PSwiWSUTryl0UkHd0RExX7nFvkNkpl1XYHN8wandhU4IP
tI20hnrtUG0=
=6DhP
-----END PGP SIGNATURE-----

-- 
Joshua Kwan


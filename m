Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTL0Tyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 14:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbTL0Tyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 14:54:55 -0500
Received: from fep01.swip.net ([130.244.199.129]:9467 "EHLO fep01-svc.swip.net")
	by vger.kernel.org with ESMTP id S264549AbTL0Tyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 14:54:53 -0500
Message-ID: <3FEDE389.4090103@free.fr>
Date: Sat, 27 Dec 2003 20:54:49 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
References: <3FED9A87.4020209@free.fr> <Pine.LNX.4.58.0312270938130.14874@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312270938130.14874@home.osdl.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
|
| On Sat, 27 Dec 2003, Jean-Luc Fontaine wrote:
|
|>I solved the problem in a very strange way. Note that the (b) disk
|>performance only improves after readahead has been increased on another
|>(c) drive! (the (c) drive performance was also increased by to 2.4
|>levels but is not shown here). I could reliably repeat this behavior
|>after rebooting.
|>
|>Can any IDE expert explain it?
|
|
| Looks like a bug. If you don't access hdc,

hdc is / for 2.6, whereas hdb is used for 2.4. So hdc was obviously
accessed prior to this test.

| then the read-ahead on hdc
| shouldn't matter. I wonder if the read-ahead code (either the setting or
| the reading) gets the value from the wrong queue or something.

Or could this set something in the VIA chipset? I'll take a look in
/proc/ide/via and report if needed.

Let me know if you need more tests to be run.

- --
Jean-Luc Fontaine  mailto:jfontain@free.fr  http://jfontain.free.fr/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/7eOIkG/MMvcT1qQRAjAxAKCr3xDbqELBzY7zsOYCQi/7QsYw7ACeObup
auyEo8bDPNHOD79+/I8/xPw=
=rsrt
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUGHRGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUGHRGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUGHRGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:06:35 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:4234 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263778AbUGHRGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:06:31 -0400
Message-ID: <40ED7F13.3050008@comcast.net>
Date: Thu, 08 Jul 2004 13:06:27 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org> <40ECF278.7070606@yahoo.com.au> <cone.1089270749.964538.4554.502@pc.kolivas.org> <40ECF86D.3060707@yahoo.com.au> <cone.1089273829.122131.4554.502@pc.kolivas.org> <40ED01FF.6010206@yahoo.com.au>
In-Reply-To: <40ED01FF.6010206@yahoo.com.au>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Nick Piggin wrote:
| Con Kolivas wrote:
|
|> Nick Piggin writes:
|> Umm I think we're agreeing, no? I'm trying to leave the swappiness
|> knob in for those who (think?) they know what they're doing. Somehow
|> it needs to be turned to "manual" again.
|>
|
| No. Fold your all "autoswappiness" stuff directly into the
| reclaim_mapped calculation that was previously keyed off swappiness.
| Don't have it modify vm_swappiness at all: work directly on
| reclaim_mapped.
|
| Then, you should be able to retain the user's vm_swappiness input
| into the system as well. If you can't figure out a good place to
| put this in, don't worry about it to start with.
|

Wasn't the point of this patch to allow the machine to tweak the
swappiness knob itself according to what it thinks is best, unless the
user tells it not to?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7X8RhDd4aOud5P8RAkNBAJ99+wIoTY1sHTTwOdO5fH8lggBpPgCfVFuv
Db7yGOwZjB+nTd6GxnM8KdM=
=/eIv
-----END PGP SIGNATURE-----

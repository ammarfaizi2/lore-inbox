Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUFLCTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUFLCTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 22:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUFLCTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 22:19:51 -0400
Received: from dev.tequila.jp ([128.121.50.153]:24070 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S264537AbUFLCTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 22:19:49 -0400
Message-ID: <40CA6835.2070405@eunet.at>
Date: Sat, 12 Jun 2004 11:19:33 +0900
From: Clemens Schwaighofer <schwaigl@eunet.at>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Clemens Schwaighofer <gullevek@gullevek.org>, linux-kernel@vger.kernel.org,
       cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
References: <40C9AF48.2040807@gullevek.org> <20040611062829.574db94f.pj@sgi.com>
In-Reply-To: <20040611062829.574db94f.pj@sgi.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Jackson wrote:

| Clemens wrote:
|
|>I think I have a similar problem like I had before:
|

nono, that part is already fixed in my patch (from mm-1). So it must be
something lese.

|
| I think that this should be the same solution as was suggested before
| by William Lee Irwin III:
|
|
|
| Index: mm1-2.6.7-rc3/include/linux/cpumask.h
| ===================================================================
| --- mm1-2.6.7-rc3.orig/include/linux/cpumask.h	2004-06-09
08:06:54.000000000 -0700
| +++ mm1-2.6.7-rc3/include/linux/cpumask.h	2004-06-09
22:30:18.000000000 -0700
| @@ -248,9 +248,9 @@
|  #endif
|
|  #define CPU_MASK_NONE							\
| -{ {									\
| +((cpumask_t) { {							\
|  	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
| -} }
| +} })
|
|  #define cpus_addr(src) ((src).bits)
|
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAymg1JwwYX0IeBp8RAmqgAJwIF05WUIxIcTFLInK8e4LYxtRkZwCgp73d
3Gcli2EsAw4YT4NFO0tS+RQ=
=coPa
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUHXJzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUHXJzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 05:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUHXJzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 05:55:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:24465 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267345AbUHXJzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 05:55:07 -0400
X-Authenticated: #4512188
Message-ID: <412B1073.2020203@gmx.de>
Date: Tue, 24 Aug 2004 11:54:59 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck kernel mailing list <ck@vds.kolivas.org>,
       Joshua Schmidlkofer <menion@asylumwear.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com> <412A271F.3040802@gmx.de> <412A663D.2050104@kolivas.org> <cone.1093304064.895888.10766.502@pc.kolivas.org> <412B0A4F.2080603@gmx.de> <cone.1093340584.747342.10766.502@pc.kolivas.org>
In-Reply-To: <cone.1093340584.747342.10766.502@pc.kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:
| Prakash K. Cheemplavam writes:
| Does it happen without nfs or not? Does it happen with only the
| staircase patch or not?

I don't think in my case it is nfs related. I have compiled it in and
nfsd is running, but in my test everything was done locally. I haven't
tested the latter, yet. (But will do later.)

|> light@tachyon ~ $ top -b -n 1
|> top - 11:22:41 up 4 min,  4 users,  load average: 2.03, 1.20, 0.51
|> Tasks:  94 total,   4 running,  90 sleeping,   0 stopped,   0 zombie
|> Cpu(s):  7.4% us, 17.3% sy, 25.2% ni, 25.8% id, 23.6% wa,  0.1% hi,
|> 0.6% si
|> Mem:   1034224k total,   646380k used,   387844k free,    39220k buffers
|> Swap:        0k total,        0k used,        0k free,   467460k cached
|
|
| You're not hitting swap.

I am not using one. ;-)

| In fact nothing is chewing up a lot of cpu time; you're just waiting
on i/o
|
|> Cpu(s):  7.4% us, 17.3% sy, 25.2% ni, 25.8% id, 23.6% wa,  0.1%
|
| hi,  0.6% si
|
| You even have 25% idle time so you have cpu to spare. Doesn't sound like
| a scheduling issue but something getting stuck during I/O.
| Something else is at play here. I need more information about the
| questions above.

Could it be cfq then? I will reboot an try with as...

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKxBzxU2n/+9+t5gRAtgXAJ9XB3LAsF9y/ZhTMBK59zyEjW/xewCfSSWv
Wn0IlxxRuuffjOtC1GUNuYU=
=CZSQ
-----END PGP SIGNATURE-----

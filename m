Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbTCQD6p>; Sun, 16 Mar 2003 22:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbTCQD6p>; Sun, 16 Mar 2003 22:58:45 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:8936 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262670AbTCQD6o> convert rfc822-to-8bit;
	Sun, 16 Mar 2003 22:58:44 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with 2.4.20-ck4
Date: Mon, 17 Mar 2003 15:09:23 +1100
User-Agent: KMail/1.5
References: <20030316201124.GA2849@triplehelix.org>
In-Reply-To: <20030316201124.GA2849@triplehelix.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303171509.34696.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Josh

On Mon, 17 Mar 2003 07:11, Joshua Kwan wrote:
> So I tried out 2.4.20-ck4 on my server box, which continually leans
> towards the experimental because, well, it seems to work fine.
>
> For 13 days, everything was peachy. Then on the 14th morning I wake
> up and dhcp3-server is not responding timely, since my laptop
> is unable to acquire an IP address automatically. I serial in and
> init has gone D and is eating 99.8% of the CPU.
>
> Every single process under init was DEFUNCT!
>
> New processes also were defunct as well, after being started. I guess
> bash was somehow not affected when I logged in.
>
> I can't provide a dmesg, since the machine eventually stopped responding
> and I had to hard reboot it. But unless I know for sure what's going on
> soon, I'll need to move back to a vanilla kernel or perhaps try out
> 2.4.20aa, without the rest of the 'desktop' tuning stuff that I don't
> really make use of.
>
> Sorry I can't give much info, except possibly my .config. You can get it
> at http://triplehelix.org/~joshk/linux/config.gz. If this happens again
> I'll be sure to get some pstree output logged somewhere. (Would slabinfo
> be useful too in this kind of situation?)

Using it on a server box? You should reverse patch the desktop tuning (patch 
010) at the very least. Your throughput will be higher without that and it 
may well be responsible for the hang.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+dUp4F6dfvkL3i1gRAuYDAJ9jr0p7iS07dQYr9IFLzoX40s0tvACdGhFJ
D8zOf7QDB0BAShCZS0HvePo=
=rOd+
-----END PGP SIGNATURE-----


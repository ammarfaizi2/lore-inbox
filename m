Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269795AbRIDX0K>; Tue, 4 Sep 2001 19:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269804AbRIDX0A>; Tue, 4 Sep 2001 19:26:00 -0400
Received: from mail.caymail.com ([199.227.10.105]:49320 "HELO pop1.netcis.com")
	by vger.kernel.org with SMTP id <S269795AbRIDXZx>;
	Tue, 4 Sep 2001 19:25:53 -0400
Date: Tue, 4 Sep 2001 19:19:53 -0700
From: Jeremiah Johnson <miah@netcis.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: Jeremiah Johnson <miah@netcis.com>
Organization: NETCIS International Corporation
X-Priority: 3 (Normal)
Message-ID: <111202114514.20010904191953@netcis.com>
To: volodya@mindspring.com
CC: linux-kernel@vger.kernel.org
Subject: Re[4]: 2.4.9 UDP broke?
In-Reply-To: <Pine.LNX.4.20.0109022221340.14074-100000@node2.localnet.net>
In-Reply-To: <Pine.LNX.4.20.0109022221340.14074-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: MD5

Hello volodya,

I found the answer to the problem today.  It has to do with a bug in
one of these options:

CONFIG_TULIP_MWI
CONFIG_TULIP_MMIO

Since the system is a older dual p100 I didn't really want to sit
through the 2 hours of compilation to "test" which one it is.  I'm
willing to bet its CONFIG_TULIP_MWI though since its still marked as
experimental.  With both of these options disabled 2.4.9 works fine on
that system though as it does on my other boxes.  Whoever maintains
the code for those two config options might want to do some testing.
I can provide more information about the system if needed.

Sunday, September 02, 2001, 7:25:44 PM, you wrote:

vmc> I had a very similar experience. In my case it turned out that for some
vmc> reason no UDP packets above 5524 would come through (try pinging with
vmc> larger than default packet sizes). The solution was to restrict NFS to
vmc> 5000 (actually 4096) size packets. I have not been able to figure out the
vmc> cause of this yet. (and yes, tcpdump was able to see them fine).

vmc>                             Vladimir Dergachev


- --
Best regards,
 Jeremiah                            mailto:miah@netcis.com

-----BEGIN PGP SIGNATURE-----
Version: 2.6

iQEVAwUAO5WLyZHTj7BlqKb5AQFiIQf8DG8rppS8oNKQvmQts2rFQzx0MVizZZv/
p12tm+bcToP8jg6OKL0hzkeL59k3RgJpbjSleHl6VHgGzZ4VfZuvtE7gwA0e/Ch8
MQck+diQkDY14qM+qxdIhwjuSyt+qDTlOPge/MZKNvtGckYkQ9qKVHiWbKWuxlYS
U4N8knpXHUZ9fM+hPPqi/0yNfwx6g7QbtLycYJzP0GIDSzP4y/P30HMkSJ9EUzP1
MQCho4dj2K2WvMyrNVAO70Nj90j1ioU7vJE2LMooKrZmWBpBSMX6MMKr//lJP73H
RTQLNZmRGbBtblq4QiXai6OpEYkaaE84iutfs9JbssOJ+S2cxNDM1g==
=XNHF
-----END PGP SIGNATURE-----


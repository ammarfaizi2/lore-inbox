Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUHMUho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUHMUho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUHMUgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:36:45 -0400
Received: from [82.154.232.131] ([82.154.232.131]:16008 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S267588AbUHMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:35:49 -0400
Message-ID: <411D2625.2070908@vgertech.com>
Date: Fri, 13 Aug 2004 21:35:49 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
 to become free. Usage count = 1
References: <411BC284.6080807@vgertech.com> <20040813080334.GA13337@tentacle.sectorb.msk.ru>
In-Reply-To: <20040813080334.GA13337@tentacle.sectorb.msk.ru>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vladimir B. Savkin wrote:
| On Thu, Aug 12, 2004 at 08:18:28PM +0100, Nuno Silva wrote:
|
|>Hi!
|>
|>With 2.6.8-rc4-bk1 I get "Aug 12 17:33:10 puma kernel:
|>unregister_netdevice: waiting for ppp0 to become free. Usage count = 1"
|>in the logs after pppd exit.
|>
|>Also, the box won't reboot and print that message forever in the
|>console. sysrq-U && sysrq-R did it :-)
|>
|>The last version I tried was 2.6.8-rc2-bk11 and, wrt this prob, is
|>running fine. So, the problem is in that window and the changelog for
|>rc4 mentions something about ppp:
|>http://kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.8-rc4
|>
|>If someone requires more information or tests feel free to ask!
|
|
| I saw this too, with 2.6.7-rc3-mm1.
| I have discovered that it happens because of idle TCP socket
| holds a reference to a network device.
| After killing associated process, device was freed immediately.
|

I waited for 5 mins before sysrq-U && sysrq-R.
Anyway, if I 'killall pppd' and then issue 'ifconfig -a' the ifconfig
command will hang.

This didn't happen with 2.6.8-rc2-bk11 (the one I'm running now), so
something changed... I'm I the only one with ppp/pppd/pppoe who tried
2.6.8-rc4-bk1? :-) Any success reports?

Regards,
Nuno Silva

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBHSYlOPig54MP17wRAs1NAJ0dMRd7tqnpRk/tnxZj7xSeoUL3UgCgrk50
tnzeT6sy3CauOI5WK7HF16o=
=mkWf
-----END PGP SIGNATURE-----

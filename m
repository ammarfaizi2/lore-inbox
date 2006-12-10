Return-Path: <linux-kernel-owner+w=401wt.eu-S1762570AbWLJVFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762570AbWLJVFP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762599AbWLJVFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:05:15 -0500
Received: from alnrmhc13.comcast.net ([204.127.225.93]:44282 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762570AbWLJVFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:05:14 -0500
Message-ID: <457C7687.4020202@comcast.net>
Date: Sun, 10 Dec 2006 16:05:11 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PAE/NX without performance drain?
References: <457B1F02.7030409@comcast.net>	 <1165743478.27217.187.camel@laptopd505.fenrus.org>	 <457C28F8.4050409@comcast.net>	 <1165779603.27217.231.camel@laptopd505.fenrus.org>	 <457C747A.6010702@comcast.net> <1165784431.27217.237.camel@laptopd505.fenrus.org>
In-Reply-To: <1165784431.27217.237.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>> OpenSuSE and Fedora Core 6 both fail this; I checked the .config for the
>> default kernels (by proxy on OpenSuSE 10.2; I asked someone) and ran my
>> test case on FC6 (LiveCD from
>> http://www.fedoraunity.org/news-archives/fedora-core-6-zod-live-spins-released).
> 
> liveCD's don't count since they pick the most common kernel; afaik
> fedora has a kernel-PAE and installs this on the NX capable machines...
> 

Nods.  No such thing in Ubuntu; and they just tore out most of their
kernels due to management overhead, saying that you should install the
BigIron (giant x86 servers with tens of gigs of memory) kernel if you
want PAE.  Of course, the BigIron kernel is for a server and doesn't
have nice low-latency features (our default desktop kernel is a 250HZ
VOLUNTARY_PREEMPT one, the low-latency kernel has 1000HZ PREEMPT; I
always thought 1000HZ PREEMPT was a good desktop default).

Things like preempt or PAE adjustment at boot time are awesome pipe
dreams, but none of them are awesomely possible/easy.  Distro
maintainers don't seem to want to supply 30 combinations ....

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXx2hQs1xW0HCTEFAQJM7xAAk1UAT/wYkgUISc6OlIfc/iWv1R34KXZM
zlbmfWBT3+mR7KgkF2e2TeADLhHlSjgMUzwG4X4rzt2W4PSk1A7kN/aPw1Qd7N+9
YaOK+4gsdCE9La5hcIgHB/uFcYNk5hLlOxvMR0oGW3p8u28F3SRolXm4O/jUfjkm
dkAGJInLL6o69zsg2zw7FhJQtLpw36XsHxJzM7hnvvmeP4uZ4Zhmil0MmG/0vK/I
cBPw0W6RTWuvFQymRsTdHLMMdkakzMAPL+y09qpgvSFO43SqWXMEXSJK4LdFZDot
PRT6J1Mb6ZwpXIgdM85PUwLXacaKzb8TGUy+XP7qeKSNaVeQzybDQg7cE0g5rEuh
15V8bJyrErKWMypxX3xikD/FG0nbBjQrIVgJZX6ZN8W5RFetpWii9qYlkgYqJu5V
T/+FxQGOU1PrsP2QNGPL1uPr+MDIPmGopD8Ap2knqeMMT/uEMa/5YKLu7Q4UPjkI
xBStmqHAsiZKt6VIybzqGmLHep0K20xPHKvwZ4E9j7R7uJz0uJID54eA+UvL8QDd
Nd/Df0xIB912w9VKaSIwlZgWDexh2nfI1kxCA1w9BH0oLEZq/2ly6Te2KStx1khT
J///xiPdMkn0oTHZepKqaFGKqDgtYvULM1HURZLbO6z+rUslqupDBzSvQcj40kTT
yjxCcrKqLgU=
=KSx+
-----END PGP SIGNATURE-----

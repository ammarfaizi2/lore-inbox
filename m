Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRKSSNQ>; Mon, 19 Nov 2001 13:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRKSSNG>; Mon, 19 Nov 2001 13:13:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47115 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280495AbRKSSM7> convert rfc822-to-8bit; Mon, 19 Nov 2001 13:12:59 -0500
Date: Mon, 19 Nov 2001 10:07:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <200111191801.fAJI1l922388@neosilicon.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id fAJICgD16567
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Sebastian Dröge wrote:
> Hi,
> I couldn't answer ealier because I had some problems with my ISP
> the heavy swapping problem while burning a cd is solved in pre6aa1
> but if you want i can do some statistics tommorow

Well, pre6aa1 performs really badly exactly because it by default doesn't
swap enough even on _normal_ loads because Andrea is playing with some
tuning (and see the bad results of that tuning in the VM testing by
rwhron@earthlink.net).

So the pre6aa1 numbers are kind of suspect - lack of swapping may not be
due to fixing the problem, but due to bad tuning.

Does plain pre6 solve it? Plain pre6 has a fix where a locked shared
memory area would previously cause unnecessary swapping, and maybe the CD
burning buffer is using shmlock..

		Linus


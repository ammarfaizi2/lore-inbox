Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUGaVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUGaVTu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUGaVTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:19:50 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:54701 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264298AbUGaVTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:19:44 -0400
Date: Sat, 31 Jul 2004 23:18:36 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bart Alewijnse <scarfboy@gmail.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: gigabit trouble
Message-ID: <20040731231836.A31121@electric-eye.fr.zoreil.com>
References: <b71082d8040729094537e59a11@mail.gmail.com> <20040729210401.A32456@electric-eye.fr.zoreil.com> <b71082d80407291541f9d6f93@mail.gmail.com> <b71082d804073008157cf1d6c0@mail.gmail.com> <20040730205412.A15669@electric-eye.fr.zoreil.com> <b71082d804073014037bc5dd5a@mail.gmail.com> <20040730234120.A15536@electric-eye.fr.zoreil.com> <b71082d804073112512bbd82e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b71082d804073112512bbd82e2@mail.gmail.com>; from scarfboy@gmail.com on Sat, Jul 31, 2004 at 09:51:27PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Alewijnse <scarfboy@gmail.com> :
[...]
> of habit as something kernely ages back wanted it. But is there really no
> point to preempting in a server?

I don't know: I have no URL for the figures at hand.

> Right, both computers now run 2.6.8-rc2-mm1. It's better. Roughly
> speaking, the top *benchmark* speeds, rouding slightly up, are:
> udp: 33MB/s (using ~26Kints) one way, 12MB/s (9Kints/s) the other, 
> tcp: 22MB/s (16Kints)one way, 12MB/s (9Kints/s) the other. 
> 
> (The 9Kints ca be 12 when the packet size is 1K or 2K)

Can you give a try to a napi version of the module (it is a compile-time
option) ?
You may want higher {r/w}mem_max as well as renicing ksoftirqd with
a strongly < 0 value on the celeron client.

> Oddly enough, the slow direction is sending from my new computer
> (XP1700, KT333, 1GB ram) to my old (both running linux and the
> mentioned kernel). I'm fairly sure this is due to the fact that my

The r8169 driver has been reported to be faster on Rx than on Tx so your
observation makes sense.

[...]
> I guess I'll have to settle for this. I'm just annoyed that the 'giga'
> is basically a joke,  especially on my setup.

It should be possible to make things slightly better for the celeron box
as a client. I'll cook up a patch.

Would you be kind enough to do some ftp transfer test where the celeron
box retrieves data and send the 'vmstat 1' output of the client during
the test ?

--
Ueimor

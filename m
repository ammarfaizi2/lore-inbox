Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSJHOiK>; Tue, 8 Oct 2002 10:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJHOiK>; Tue, 8 Oct 2002 10:38:10 -0400
Received: from aneto.able.es ([212.97.163.22]:23936 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S261333AbSJHOiI>;
	Tue, 8 Oct 2002 10:38:08 -0400
Date: Tue, 8 Oct 2002 16:43:28 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.10
Message-ID: <20021008144328.GC1560@werewolf.able.es>
References: <Pine.LNX.4.44L.0210081135290.1909-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44L.0210081135290.1909-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 08, 2002 at 16:38:36 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.08 Rik van Riel wrote:
>On Tue, 8 Oct 2002, J.A. Magallon wrote:
>
>> It also kills the 'states' part, things are beginning to spread past 80
>> columns...is it very important ?
>
>Yes, things should stay within 80 lines.
>

You can also kill the commas ',', they look not so important:

CPU0:   0,0% user   0,0% system   0,0% nice   0,0% iowait 100,0% idle
CPU1:   0,4% user   0,3% system   0,0% nice   0,0% iowait  98,3% idle

>> I am gettin also strange outputs sometimes, with a ton of digits in
>> decimal parts.
>
>Wait... I remember fixing that bug.  On 2.4 kernels iowait
>should always be 0.0% and it always is 0.0% here.
>
>I have no idea why it's displaying a wrong value on your
>system, unless you somehow managed to run against a wrong
>libproc.so (shouldn't happen).
>

werewolf:/lib# which top
/usr/bin/top
werewolf:/lib# ldd `which top`
        libproc.so.2.0.10 => /lib/libproc.so.2.0.10 (0x1557b000)
        libncurses.so.5 => /lib/libncurses.so.5 (0x15589000)
        libc.so.6 => /lib/i686/libc.so.6 (0x155ce000)
        libgpm.so.1 => /usr/lib/libgpm.so.1 (0x156ee000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x15556000)

???

Will take a look.

By.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))

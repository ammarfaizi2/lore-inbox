Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbSJHOsZ>; Tue, 8 Oct 2002 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262676AbSJHOsZ>; Tue, 8 Oct 2002 10:48:25 -0400
Received: from aneto.able.es ([212.97.163.22]:33664 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S261764AbSJHOsY>;
	Tue, 8 Oct 2002 10:48:24 -0400
Date: Tue, 8 Oct 2002 16:53:40 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.10
Message-ID: <20021008145340.GE1560@werewolf.able.es>
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

It looks like the 2 first screenshots show buggy data:

First:
CPU0:   0,1% user   0,1% system   0,0% nice  99,18% iowait   0,103% idle
CPU1:   0,0% user   0,4% system   0,0% nice  99,18% iowait   0,101% idle

Second:
CPU0:   0,15% user   0,4% system   0,0% nice   4,1070639% iowait   0,434% idle
CPU1:   0,13% user   0,7% system   0,0% nice   4,1070639% iowait   0,433% idle

Third:
CPU0:   3,1% user   2,3% system   0,0% nice   0,0% iowait  94,0% idle
CPU1:   3,3% user   2,0% system   0,0% nice   0,0% iowait  94,1% idle

Always the same, does not depend on interval. Samples above were taken with
top -d100.

Hope this helps.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268928AbRG0TV2>; Fri, 27 Jul 2001 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268932AbRG0TVS>; Fri, 27 Jul 2001 15:21:18 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:3264 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268928AbRG0TVJ>; Fri, 27 Jul 2001 15:21:09 -0400
Message-Id: <4.3.1.0.20010727121014.055d4c90@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Fri, 27 Jul 2001 12:21:46 -0700
To: kuznet@ms2.inr.ac.ru
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: 2.4.7 softirq incorrectness.
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200107271859.WAA24210@ms2.inr.ac.ru>
In-Reply-To: <4.3.1.0.20010727112236.03454b30@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > Also it doesn't fix the scenario that I described (reschedule while running). I'm still wondering why don't I hit that trylock/BUG 
> > in tasklet_action.
>
>How old the problem is ? Was it always present ?
That's a good question. Data ordering check in Bluetooth tools was introduced pretty recently.
So, before 2.4.7 I wasn't paying attention to it and there for didn't notice any problems with 
tasklets.

>To be honest, this is too strong bug to believe to this at all. :-)
:) Agree. But I checked all my code, tx_task is called from tasklet only. And I do see that it's getting run on several 
cpus at the same time.

Also don't you agree with that it's possible (at least in theory) to hit that trylock/BUG in tasklet_action ?

Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131318AbRCMWqv>; Tue, 13 Mar 2001 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131319AbRCMWqm>; Tue, 13 Mar 2001 17:46:42 -0500
Received: from colorfullife.com ([216.156.138.34]:52742 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131318AbRCMWqd>;
	Tue, 13 Mar 2001 17:46:33 -0500
Message-ID: <000701c0ac0f$67425060$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Chris Evans" <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0103132128110.20010-100000@ferret.lmh.ox.ac.uk>
Subject: Re: system hang with "__alloc_page: 1-order allocation failed"
Date: Tue, 13 Mar 2001 23:45:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chris Evans" <chris@scary.beasts.org>
>
> I thought (on Intel) there was a 4092 hard limit?
>
That's the 2.2 limit, it's gone.

The new limit is total memory and pid space. The pid's are intentionally
limited to 15 bits, the remaining bits are reserved.

In the worst case one running process can block 3 pid values (one for
the session, one for the process group, one for process id), thus
~11.000 running processes can exhaust the pid space.

--
    Manfred


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273495AbRI3NV2>; Sun, 30 Sep 2001 09:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273504AbRI3NVR>; Sun, 30 Sep 2001 09:21:17 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:7577 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273495AbRI3NVE>; Sun, 30 Sep 2001 09:21:04 -0400
Date: 30 Sep 2001 11:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: kuznet@ms2.inr.ac.ru
cc: linux-kernel@vger.kernel.org
cc: mingo@elte.hu
Message-ID: <89pdkdu1w-B@khms.westfalen.de>
In-Reply-To: <200109291635.UAA17377@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200109291635.UAA17377@ms2.inr.ac.ru>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru  wrote on 29.09.01 in <200109291635.UAA17377@ms2.inr.ac.ru>:

> Essentially, if we invent some real condition when softirq loop must be
> stopped, we win. Now it is "stop after all events pending at start are
> processed". OK, it is wrong. You propose: "10 rounds". It is even worse
> because it is against plain logic. (pardon :-)).

The way I understand from this thread, the condition is *not* "10 rounds",  
it is "no more new softirqs are pending when we want to leave" - except it  
does a sort of emergency abort if 10 rounds weren't enough to get to that  
condition.

MfG Kai

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132209AbRCVVsj>; Thu, 22 Mar 2001 16:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132211AbRCVVs3>; Thu, 22 Mar 2001 16:48:29 -0500
Received: from colorfullife.com ([216.156.138.34]:20485 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132209AbRCVVsO>;
	Thu, 22 Mar 2001 16:48:14 -0500
Message-ID: <000401c0b319$c2ba7dd0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <geirt@powertech.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Serial port latency
Date: Thu, 22 Mar 2001 22:45:58 +0100
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

Is the computer otherwise idle?
I've seen one unexplainable report with atm problems that disappeared
(!) if a kernel compile was running.

Could you try to run a simple cpu hog (with nice 20)?

<<
main()
{
    for(;;) getpid();
}
<<

I'm aware of one bug that could cause a delay of up to 20 ms (cpu_idle()
doesn't check for pending softirq's before sleeping), but that doesn't
explain your 500 ms delay.

--
    Manfred


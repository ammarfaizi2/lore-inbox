Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSGBSXA>; Tue, 2 Jul 2002 14:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSGBSW7>; Tue, 2 Jul 2002 14:22:59 -0400
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:11276 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S316845AbSGBSW7>; Tue, 2 Jul 2002 14:22:59 -0400
From: "Stephane Charette" <stephanecharette@telus.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jul 2002 11:25:27 -0700
Reply-To: "Stephane Charette" <stephanecharette@telus.net>
X-Mailer: PMMail 2000 Standard (2.20.2502) For Windows 2000 (5.0.2195;2)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: what is the performance impact of using "idle=poll"?
Message-Id: <20020702182259Z316845-685+2263@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading through "The Linux BootPrompt-HowTo" at "http://www.ibiblio.org/mdw/HOWTO/BootPrompt-HOWTO.html".

In section 3.5, I found the following:

   The `idle=' Argument

   Setting this to `poll' causes the idle loop in the
   kernel to poll on the need reschedule flag instead
   of waiting for an interrupt to happen.  This can
   result in an improvement in performance on SMP
   systems (albeit at the cost of an increase in power
   consumption).

I tried to run a few performance tests with 2.4.19-pre9-vanilla-SMP running on a dual-CPU Athlon 1600MHz box.  Idle polling was enabled as evidenced by the message "using polling idle threads" on bootup.

While my tests were limited in nature (webstone against an in-house web server, thus not reproducable within the open community), I saw a performance degrade with the "idle=poll" option instead of seeing any performance increase.  In one set of tests, idle=poll resulted in 1% degradation, while another run (with the scheduling patch) showed a 2.6% hit.  The actual values of my performance tests are not important -- the trend is what I wish to higlight.

My questions:

1) is this a known issue?
2) Was "idle=poll" an old performance hack that no longer applies to the newer kernels but remains in the code?
3) Should it still valid?
4) Has anyone run benchmarks recently and seen a performance hit with idle=poll, instead of the possible "improvement in performance" as stated in the HOW-TO?

A search on google has shown some fairly recent discussion on the kernel list about idle=poll, but nothing that was either definitive, nor conclusive, especially in regards to performance impacts on an SMP kernel running on an SMP box.

Thanks,

Stephane Charette



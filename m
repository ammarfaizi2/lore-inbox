Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284011AbRLAI2x>; Sat, 1 Dec 2001 03:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284010AbRLAI2n>; Sat, 1 Dec 2001 03:28:43 -0500
Received: from mail.spylog.com ([194.67.35.220]:52449 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S284008AbRLAI2Y>;
	Sat, 1 Dec 2001 03:28:24 -0500
Date: Sat, 1 Dec 2001 11:31:30 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <61437219298.20011201113130@spylog.ru>
To: theowl@freemail.c3.hu
Cc: theowl@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <3C082244.8587.80EF082@localhost>
In-Reply-To: <3C082244.8587.80EF082@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello theowl,

Saturday, December 01, 2001, 2:20:20 AM, you wrote:

Well. Thank you. I've allready found this - in recent kernels it's
even regulated via proc fs.

The only question is why map anonymous is rather fast (i get
1000req/sec even then mapped 300.000 of blocks), therefore with
mapping a fd the perfomance drops to 20req/second at this number.

Any ideas why does this happen or any patches which increases the
speed exists ?

tfch> in include/linux/sched.h:

tfch> /* Maximum number of active map areas.. This is a random (large) number */
tfch> #define MAX_MAP_COUNT   (65536)

tfch> this should probably be (TASK_SIZE / PAGE_SIZE) on 32 bit architectures
tfch> and something 'reasonably big' on 64 bit (too big of a value would
tfch> allow for a nice DoS against the kernel).



-- 
Best regards,
 Peter                            mailto:pz@spylog.ru


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136474AbRA1CZH>; Sat, 27 Jan 2001 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136609AbRA1CY6>; Sat, 27 Jan 2001 21:24:58 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36902 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S136474AbRA1CYl>; Sat, 27 Jan 2001 21:24:41 -0500
Message-ID: <3A738289.4F7CBBFA@sgi.com>
Date: Sat, 27 Jan 2001 18:23:05 -0800
From: Linda Walsh <law@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 Cpu usuage (display oddities more than anything)
In-Reply-To: <3A7381C2.C512B76C@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some oddities w/kapmd(2.4.0)...  If I sit in X and do nothing other than run top or
"vmstat 5", I get down to as low as 60% idle and 40% in system -- with kapmd getting
'charged' for the 40%.

Then I go and run 'freeamp' and the CPU usage goes to 100% idle, presumably because
kapmd never gets called because it's never in the idle loop for longer than 333ms.

It's just weird and unnatural.

Also forgive my ignorance but is it really possible playing VBR MP3's takes 0 measurable
CPU?  I've run the program for hours and a ps of 'freeamp' show either no measured cpu 
time or maybe 1 second...the kernel runs at at 100% idle for most of the time.
I thought mp3 decompression was a cpu intensive operation....weird...

I guess I'm thinking -- maybe time in kapmd should be counted as 'idle'?

-l
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

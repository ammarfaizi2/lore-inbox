Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbRBXOeP>; Sat, 24 Feb 2001 09:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129378AbRBXOeF>; Sat, 24 Feb 2001 09:34:05 -0500
Received: from web1302.mail.yahoo.com ([128.11.23.152]:65040 "HELO
	web1302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129374AbRBXOeA>; Sat, 24 Feb 2001 09:34:00 -0500
Message-ID: <20010224143354.15276.qmail@web1302.mail.yahoo.com>
Date: Sat, 24 Feb 2001 06:33:54 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: 2.4.2-ac3 == 400% speed improvement with Java
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

any 2.4.1-ac5 kernel and above until 2.4.2-ac3 had a bug (Ingo guessed
it might be the yield() bug) that made Java (and some other things
*really* slow). This is fixed now. When I profiled slow kernels the
mtrr_file_add was taking up all of the time - even though I had
disabled mtrr in my kernel (it wasn't in /proc).

(Alan Cox: I'm not sure if the yield() bug was the problem, or if that
patch was in the TUX patch (based on -ac3) or the -ac3 patch.)

Here was the old test: (With 2.4.2-ac3 things are even faster than
2.2.14 at 0:00.44elapsed!!)

(jdk1.3.0_01)
> time java
(done multiple times so everything is in cache)

On 2.2.14 (400MHz Celeron/192MB RAM) this takes about 0.66ms.
0.37 user 0.07 system  0:00.62elapsed 70% CPU (oavgtext+0avgdata
0maxresident)k
0inputs+0outputs (3957major+1707minor)pagefulats 0swaps

On linux 2.4.2-ac1-TUX (same machine)

0.33 user 2.17 system 0:03.49elapsed 71%CPU (ovgtext+0avgdata
0maxresident)k
0inputs+0outputs (3987major+1784minor)pagefaults 0swaps


__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/

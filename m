Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282401AbRKXIJw>; Sat, 24 Nov 2001 03:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282403AbRKXIJn>; Sat, 24 Nov 2001 03:09:43 -0500
Received: from mail.spylog.com ([194.67.35.220]:9907 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S282401AbRKXIJb>;
	Sat, 24 Nov 2001 03:09:31 -0500
Date: Sat, 24 Nov 2001 11:11:55 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <97219676688.20011124111155@spylog.ru>
To: Anton Petrusevich <casus@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: threads & /proc
In-Reply-To: <20011123233857.A25084@casus.tx>
In-Reply-To: <20011123233857.A25084@casus.tx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anton,

Saturday, November 24, 2001, 8:38:57 AM, you wrote:


I would confirm the problem exists from the first 2.4.x kernels. Also
programs "w","vmstat","snmpd" hangs.  It seems to happen both for
UP/SMP kernels. I have seen this only on High Memory (1-2G), therefore
I do not have much low memory machines loaded.  The workload seems to
be the thing to affect this - I do not remember any hang on low VM
load system (for example Web Server) therefore it's offen happens
then there are a lot of I/O  and swapping goes (i.e Mysql Server).
Often this happens after appearing some of new __order allocation
failed errors.




Other issue which looks like connected to this - a thread hangs in
"D" state forever and it's unable to be killed in this case even
reboot -f does not work.

AP> Hi Guys,

AP> Well, I'm a bit surprised that nobody asked it yet. Do we have sound
AP> thread support? I am able to put my linux-2.4.15-pre{1,7} --
AP> definitely, and if I remember right, 2.4.14-pre{7,8} too in some strange
AP> state, when any program like top, killall or ps that wanna get some
AP> information from /proc (even midnight commander if you are trying to
AP> look at state of any process) blocks indefinitely. It goes to unclean
AP> shutdown, for example. kill doesn block, but do nothing. (I tried to
AP> kill processes from ls /proc list). And I see it only after several
AP> [unsuccessful] runs of my multithreaded program. Well, I can't say 
AP> it's a correctly written program, I am still looking for bugs there. 
AP> I don't have 100% way to get into this state, but I suspect some locking
AP> issues with /proc. 



-- 
Best regards,
 Peter                            mailto:pz@spylog.ru


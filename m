Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281215AbRKYXzI>; Sun, 25 Nov 2001 18:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281224AbRKYXy6>; Sun, 25 Nov 2001 18:54:58 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:49594 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281215AbRKYXy4>; Sun, 25 Nov 2001 18:54:56 -0500
Message-ID: <3C01D737.5020308@free.fr>
Date: Mon, 26 Nov 2001 00:46:31 -0500
From: FORT David <popo.enlighted@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011121
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>
CC: Anton Petrusevich <casus@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: threads & /proc
In-Reply-To: <20011123233857.A25084@casus.tx> <97219676688.20011124111155@spylog.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:

>Hello Anton,
>
>Saturday, November 24, 2001, 8:38:57 AM, you wrote:
>
>
>I would confirm the problem exists from the first 2.4.x kernels. Also
>programs "w","vmstat","snmpd" hangs.  It seems to happen both for
>UP/SMP kernels. I have seen this only on High Memory (1-2G), therefore
>I do not have much low memory machines loaded.  The workload seems to
>be the thing to affect this - I do not remember any hang on low VM
>load system (for example Web Server) therefore it's offen happens
>then there are a lot of I/O  and swapping goes (i.e Mysql Server).
>Often this happens after appearing some of new __order allocation
>failed errors.
>
>
>
>
>Other issue which looks like connected to this - a thread hangs in
>"D" state forever and it's unable to be killed in this case even
>reboot -f does not work.
>
>AP> Hi Guys,
>
>AP> Well, I'm a bit surprised that nobody asked it yet. Do we have sound
>AP> thread support? I am able to put my linux-2.4.15-pre{1,7} --
>AP> definitely, and if I remember right, 2.4.14-pre{7,8} too in some strange
>AP> state, when any program like top, killall or ps that wanna get some
>AP> information from /proc (even midnight commander if you are trying to
>AP> look at state of any process) blocks indefinitely. It goes to unclean
>AP> shutdown, for example. kill doesn block, but do nothing. (I tried to
>AP> kill processes from ls /proc list). And I see it only after several
>AP> [unsuccessful] runs of my multithreaded program. Well, I can't say 
>AP> it's a correctly written program, I am still looking for bugs there. 
>AP> I don't have 100% way to get into this state, but I suspect some locking
>AP> issues with /proc. 
>
>
>
I've also seen the case on a UP, ps was locking. And i had launched a
lot of multi-threaded processes(but i don't know if it's related).
I can had that i had also launched a lot of gdb on the multi-threaded
program. The program i was debugging is forking a process in a thread
that dies after the fork.

-- 
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/PHP/java/JSPs              |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlightened....          |  ^^-^^                        %
%                              HomePage: http://www.enlightened-popo.net  %
%---------- -- This was sent by Djinn running Linux 2.4.13 -- ------------%




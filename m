Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTFGRbq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTFGRbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:31:46 -0400
Received: from relay1.volja.net ([217.72.64.59]:47887 "EHLO relay1.volja.net")
	by vger.kernel.org with ESMTP id S263298AbTFGRbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:31:45 -0400
Date: Sat, 7 Jun 2003 19:48:00 +0200
From: Andrej Hocevar <drejcica@volja.net>
To: linux-kernel@vger.kernel.org
Subject: advice on adding functions to use with "loadkeys" (keyboard.c maybe?)
Message-ID: <20030607174800.GA10131@sonet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Weltschmerz: A la recherche du temps perdu
X-alter-ego: Woody Allen
X-always: Counting Crows!
X-me: the only friendly hacker
X-geek: GL/AT d+(>pu) s: a--(-----(+++))>-- C++(>---) UL+++ P+++ L+++ !E W+ N-- o-- k? w- O? M? V? PS PE Y PGP- t+ 5? X- R- tv- b+++$ DI? !D G e(>++++) h---(>) r++(--) y+++
X-OS: Debian GNU/Linux 3.0@2.4
X-Host: sonet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
in many trivial situations, one cannot make good use of common
techniques for mapping certain functions to certain keys in the
console. For example, using "loadkeys" to make F1 start
"fetchmail\n" or something similar is convenient in most cases. But
if one wants to make it change the keyboard-layout (like "loadkeys
us"), it won't make much sense to use the previous approach, since
it won't work from within an editor. Instead, a solution would be to
map a key to "KeyboardSignal" and point it to a script from
/etc/inittab. 

Now here's my question: the last approach is good but even if one
maps multiple keys to the same signal, I don't see a way for the
script to know which key was pressed to run it. So I thought I could
add some custom functions to do mostly trivial tasks, maybe something
like "ls -l" to test its functionality, and then use "loadkeys" to
map a key to that new function. Is this possible? Is it a good idea
at all? 

Thanks,
    andrej

-- 
echo ${girl_name} > /etc/dumpdates

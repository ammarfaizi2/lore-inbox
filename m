Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756548AbWKSKtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbWKSKtB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 05:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756549AbWKSKtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 05:49:01 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:16526 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1756548AbWKSKtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 05:49:00 -0500
Date: Sun, 19 Nov 2006 11:47:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Oleg Verych <olecom@flower.upol.cz>
cc: Folkert van Heusden <folkert@vanheusden.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
In-Reply-To: <20061119071343.GA16125@flower.upol.cz>
Message-ID: <Pine.LNX.4.61.0611191144550.24349@yvahk01.tjqt.qr>
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz>
 <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com>
 <20061118023832.GG13827@flower.upol.cz> <Pine.LNX.4.61.0611182029150.10940@yvahk01.tjqt.qr>
 <20061118215117.GA15686@flower.upol.cz> <Pine.LNX.4.61.0611190020400.8225@yvahk01.tjqt.qr>
 <20061119071343.GA16125@flower.upol.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 19 2006 07:13, Oleg Verych wrote:
>On Sun, Nov 19, 2006 at 12:24:14AM +0100, Jan Engelhardt wrote:
>> On Nov 18 2006 21:51, Oleg Verych wrote:
>> >On Sat, Nov 18, 2006 at 08:30:02PM +0100, Jan Engelhardt wrote:
>> >> >Then, who you think prints that "Killed" or "Segmentation fault"
>> >> >messages in *stderr*?
>> >> >[Hint: libc's default signal handler (man 2 signal).]
>> >> 
>> >> Please enlighten us on how you plan to catch the uncatchable SIGKILL.
>> >
>> >Here's question of getting information. Collecting information is
>> >possible by `waitpid()' from parent process as Miquel noted.
>> 
>> Yes, that is true. However that would involve adding support for This 
>> Situation to the parent process. Which is where it becomes tricky. Patch 
>> /sbin/init, in case the daemon runs like everything else. Or patch 
>> xinetd, in case it is run from within that. Or, ...
>>   The 'problem' with the waitpid solution is that you would need to 
>> patch every possible parent that may become the owner of The Sigkilled 
>> Target.
>
>I think this is pure userspace admin issue, one wrapper shell script
>for not programmers.
>
>I'm not sure about init, you've told. For example, in Debian daemons are
>run by start-stop-daemon function in LSB package. And in proposed LSB
>standard <http://refspecs.freestandards.org/LSB_3.1.0/LSB-Core-generic/>
>portable start_daemon, killproc, pidofproc funcions are described.

But usually the start wrapper will succeed, and the daemon will 
eventually get reparented to init. At least this is the case in 
LSB-compliant distros like opensuse and fedora.


	-`J'
-- 

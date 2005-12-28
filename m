Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVL1Oke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVL1Oke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVL1Okd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:40:33 -0500
Received: from main.gmane.org ([80.91.229.2]:59815 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964829AbVL1Okb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:40:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: How to debug FTP messaging in Linux FTP server
Date: Wed, 28 Dec 2005 23:40:12 +0900
Message-ID: <43B2A3CC.60608@thinrope.net>
References: <c2bc1f40512280455w67b3db2cx4de6e32d50f5b760@mail.gmail.com> <c2bc1f40512280557w44d41e8fm58273fb96a1b6726@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: jeanwelly@gmail.com
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <c2bc1f40512280557w44d41e8fm58273fb96a1b6726@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeanwelly wrote:
> Hi, All
> I am using PowerPC target board and want to transfer files from board
> to a Linux FTP server.
What is the server software? vsftpd, ProFTPD, wuftp, whatever

> The current issue is that FTP server returns ERROR when I sending
> "STOR filename" from client.

> But command "TYPE type", "PASS password" and "USER username" can work
> correctly between board and server.
> 
> My question is how can I debug  or what tools can be used in Linux
> server to track what's going on in server.
#-2 Check if the user the server is running (do _NOT_ tell me it is running as root!) can write to
the directory
#-1 Look into the logs of the server.
#0 Read your server software FAQ.
#1 RTFM: Read your server software manual.
#2 turn on debugging and possibly keep it in foreground (do not daemonize it), increase debug
level/verbosity
#3 if still not clear try running an `strace -f -e open SERVER_COMMAND_HERE`
#4 still here? try `strace -f SERVER_COMMAND_HERE`
#5 `man strace`
#6 use a debugger like gdb

#F Hire a professional consultant to solve your particular problem :-)

I bet you will be up and running befre going on the positive numbers :-) Above level #4 you need
good programming/debugging skills which you are not likely to have based on your question.

> I guess there should be a lot of scenarios which can caused the STOR
> command get error return code, I appreciate if you can list some.
Yes, you are very right.

And BTW, this list is for linux kernel not for linux in general (as your question is). I should have
ignored you, but I am in "Reply" mode now :-)

Good luck!

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130367AbRAAW1p>; Mon, 1 Jan 2001 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRAAW1Z>; Mon, 1 Jan 2001 17:27:25 -0500
Received: from isis.telemach.net ([213.143.65.10]:34063 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S130367AbRAAW1V>;
	Mon, 1 Jan 2001 17:27:21 -0500
Message-ID: <3A50FD1F.A008B64F@telemach.net>
Date: Mon, 01 Jan 2001 22:56:47 +0100
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: andrea@suse.de, jef@acme.com
Cc: linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?) 
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

After more-than-expected amount of hours spent on this, i managed to
localize the problem and found a partial solution.
I ran a series of test with thttpd compiled on rh6 and rh7 serving a
couple of files on different kernels. In the first run i used 6 average
sized mp3s and could not reproduce the problem, but then i added a
couple of 100mb and 200mb mpeg videos and boing, there it was.

		libc		
kernel		version		result

2.2.18raid	2.1.3		ok
2.2.18raid	2.1.94		ok
2.2.18cdhs	2.1.3		crash at the third simultaneous connection
2.2.18cdhs	2.1.94		ok
2.2.19pre3aa4	2.1.3		ok
2.2.19pre3aa4	2.1.94		ok
2.4.0-test10	2.1.3		ok
2.4.0-test10	2.1.94		ok

Now i use thttpd statically compiled with newer libc with the 2.2.18cdhs
on the box that was making problems before and so far it runs smooth.
If anyone is interested of strace outputs of above tests and wants to
discover the source of the problem, i can help.

-- 


Pegasus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

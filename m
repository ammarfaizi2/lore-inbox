Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbTFWDnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 23:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbTFWDnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 23:43:46 -0400
Received: from [203.149.0.18] ([203.149.0.18]:12795 "EHLO
	krungthong.samart.co.th") by vger.kernel.org with ESMTP
	id S265022AbTFWDno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 23:43:44 -0400
Message-ID: <3EF67AD4.4040601@thai.com>
Date: Mon, 23 Jun 2003 10:58:12 +0700
From: Samphan Raruenrom <samphan@thai.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030320
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Crusoe's performance on linux?
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz>
In-Reply-To: <20030619221126.B3287@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Could you a test just for me? Take vanilla 2.4.21 and then
> make oldconfig; make dep; time make bzImage 
> That's basically what I want to know how long will take, since
> it's one of the most common time consuming tasks the thing will
> have to handle.
Done! Here're the results:-

Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.

 From freshdiagnos benchmack, the TPC has about 2x faster RAM.
I use tmpfs for the whole process so disk speed didn't count.
Both test run without X or any foreground process using
2.4.21-ac1 and RedHat kernel.

What do you think?
Shouldn't TM5800 with 4-wide VLIW engine and 64 registers,
working on a single task, run as fast as a Pentium III?
Why it take 70% longer for such small process (make+gcc+as)!
There must be something wrong.


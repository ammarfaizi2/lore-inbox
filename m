Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUBGW0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 17:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUBGW0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 17:26:40 -0500
Received: from ra.abo.fi ([130.232.213.1]:56316 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id S265920AbUBGW0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 17:26:38 -0500
Message-ID: <402567EE.3050804@abo.fi>
Date: Sun, 08 Feb 2004 00:34:22 +0200
From: Marcus Alanen <marcus.alanen@abo.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031115 Debian/1.5-3.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: "-rb (Robert T. Brown)" <rbrown@netmentor.com>
CC: linux-kernel@vger.kernel.org, maalanen@abo.fi
Subject: Re: getcwd() returning -ENOENT???
References: <40255AE4.6010007@netmentor.com>
In-Reply-To: <40255AE4.6010007@netmentor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checking-Host: melitta.abo.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-rb (Robert T. Brown) wrote:
> Greetings.
> I have 2 clients and a server.  On one client, every 24-72 hours
> I get into a situation where the shells cd'ed into
> my [automounted] home directory report:
> 
> gretchen@falcon{11}pwd
> pwd: cannot get current directory: No such file or directory

I've had this exact same thing. I start konsole and write "pwd", 
resulting in an error message. Merely cd:ing again "fixes" it, as you 
have also noted. My home directory was mounted over NFS. This was on a 
Fedore 1 machine with their kernel. The mountpoint was not automounted, 
however.

I wrote a C program whose only purpose was to print the current working 
directory using getcwd(3). Immediately after starting konsole, the 
program failed every time; after cd:ing it started working.

I can't unfortunately remember any further details like exact glibc or 
kernel version, and I've also lost any strace or tcpdump from that time 
as well. The problem was extremely persistent for a week or so, then 
suddenly stopped occurring. And I think neither the NFS server nor the 
client was rebooted in between.

You might want to try dumping the traffic and checking with ethereal 
what is actually sent across the wire, in both directions.

Marcus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUHQTeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUHQTeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUHQTeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:34:11 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:38239 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266630AbUHQTeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:34:07 -0400
Message-ID: <41225D16.2050702@microgate.com>
Date: Tue, 17 Aug 2004 14:31:34 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com>
In-Reply-To: <2a4f155d04081712005fdcdd9b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail dönmez wrote:

> But some other problems remain and the real
> issue is /dev/tty is a directory now! :
> 
> 
> cartman@southpark:~$ ls -al /dev/tty
> total 0
> drwxr-xr-x   2 root root     0 2004-08-18 00:52 ./
> drwxr-xr-x  15 root root     0 2004-08-17 21:53 ../
> crw-------   1 root root 3, 10 2004-08-18 00:52 s
> crw-------   1 root root 3,  0 2004-08-18 00:52 s0
> crw-------   1 root root 3,  1 2004-08-18 00:52 s1
> crw-------   1 root root 3,  2 2004-08-18 00:52 s2
> crw-------   1 root root 3,  3 2004-08-18 00:52 s3
> crw-------   1 root root 3,  4 2004-08-18 00:52 s4
> crw-------   1 root root 3,  5 2004-08-18 00:52 s5
> crw-------   1 root root 3,  6 2004-08-18 00:52 s6
> crw-------   1 root root 3,  7 2004-08-18 00:52 s7
> crw-------   1 root root 3,  8 2004-08-18 00:52 s8
> crw-------   1 root root 3,  9 2004-08-18 00:52 s9
> 
> 
> And this breaks many applications. Any idea why /dev/tty is a directory now?

That does not look right.
Char dev 3 is the pty major.
This could be left over from running with the controlling-tty patch.

Try recreating /dev/tty as a char special file:
mknod -m 666 /dev/tty c 5 0

--
Paul Fulghum
paulkf@microgate.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUHQVSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUHQVSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbUHQVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:18:39 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:64362 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268470AbUHQVNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:13:37 -0400
Message-ID: <412272C8.6050203@microgate.com>
Date: Tue, 17 Aug 2004 16:04:08 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.org,
       greg@kroah.com
Subject: Re: 2.6.8.1-mm1 Tty problems?
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com>
In-Reply-To: <2a4f155d04081712005fdcdd9b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail dönmez wrote:

> On Tue, 17 Aug 2004 13:36:11 -0500, Paul Fulghum <paulkf@microgate.com> wrote:
> 
>>Even if a feature is not be enabled,
>>backing out a patch can verify it does not
>>touch code outside of the feature.
>>
> 
> 
> Indeed backing up selinux-revalidate-access-to-controlling-tty.patch
> fixed "less" problem. But some other problems remain and the real
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

Olaf, Greg:

The addition of pty devices to sysfs in bk-driver-core.patch
of 2.6.8.1-mm1 seems to be causing the problem described above.
See the rest of this thread for more details.

--
Paul Fulghum
paulkf@microgate.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266191AbSLSVC7>; Thu, 19 Dec 2002 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSLSVC7>; Thu, 19 Dec 2002 16:02:59 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:14833 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP
	id <S266191AbSLSVC7>; Thu, 19 Dec 2002 16:02:59 -0500
Message-ID: <3E023602.8080007@verizon.net>
Date: Thu, 19 Dec 2002 16:11:30 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
References: <200212192032.gBJKWSpe002662@darkstar.example.net>
In-Reply-To: <200212192032.gBJKWSpe002662@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out004.verizon.net from [64.223.83.18] at Thu, 19 Dec 2002 15:10:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

> [snip]
>
>Interesting - so the first stage in reporting a bug would be to select
>the latest 2.4 and 2.5 kernels that you've noticed it in, and get a
>list of known bugs fixed in those versions.  Also, if you'd selected
>the maintainer, (from an automatically generated list from the
>MAINTAINERS file), it could just search *their* changes in the changelog.
>
It's often difficult to pick a maintainer for a bug - it may not be the 
fault of a single subsystem.  As an example, I recently had a problem 
getting USB and network to function (on kernels 2.5.5x).  I noticed that 
toggling Local APIC would also toggle which of the two devices worked. 
 Disabling ACPI allows both deviecs to function regardless of local APIC.

So, where is the problem?
1) Network driver?  It doesn't work with ACPI and both Local APIC and 
IO-APIC.
2) USB driver?  It doesn't work with ACPI and no UP APIC.
3) APIC?  Causes weird problems with various drivers when ACPI is turned on.
4) ACPI?  Causes weird problems with various drivers when APIC is toggled.

(this exact bug was in Bugzilla, though I hadn't checked there before 
mailing lkml ;)

I'm not exactly a neophyte to the kernel, and I would have to do a lot 
more digging to find the right maintainer to send this to.  Also, the 
person(s) to whom the bug is reported will depend on how much debugging 
work I do, and in what order I do it.

I'm not trying to discourage you - just raising a potential gotcha.

- Steve



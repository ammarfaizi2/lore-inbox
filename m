Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVDXB7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVDXB7V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 21:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVDXB7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 21:59:21 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:32958 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262225AbVDXB7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 21:59:13 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
	<1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
	<20050423170152.6b308c74.akpm@osdl.org>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Date: Sun, 24 Apr 2005 03:59:06 +0200
In-Reply-To: <20050423170152.6b308c74.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 23 Apr 2005 17:01:52 -0700")
Message-ID: <87fyxhj5p1.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Juergen Kreileder <jk@blackdown.de> wrote:
>>
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>
>>> On Fri, 2005-04-15 at 20:23 +0200, Juergen Kreileder wrote:
>>>> Juergen Kreileder <jk@blackdown.de> writes:
>>>>> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
>>>>
>>>> I think I finally found the culprit.  Both rc2-mm3 and rc1-mm1
>>>> work fine when I reverse the timer-* patches.
>>>>
>>>> Any idea?  Bug in my ppc64 gcc?
>>>
>>> Or a bug in those patches,
>>
>> Probably.  I've tried a different toolchain now (3.4.3), didn't
>> help.
>
> That is bad news.
>
> I wonder why you're the only person who has noticed this.

Me too.

> How frequent are the lockups?

It only happens when running Azareus with IBM's Java (our's isn't
ready yet).
So far I was able to reproduce the problem on all -mm versions within
one hour.  Otherwise the kernels seem to work fine -- no lockup unless
I run Azareus.

I'm running rc2-mm3 without the timer- patches now.  It's up for 6
days now and survived downloading all Ubuntu torrents over ten times.

> Is it possible to perform any additional debugging?

> Do you think there's anything unusual in your driver lineup or in
> your workload which would cause you to be the only person who is
> observing this?

I'm might be the only one using evdev on ppc64.

And I don't know how popular LVM2 is on disks with Macintosh labels.
I had to set it up manually when I installed the machine, Debian's
installer couldn't handle it at that time.

Workload is normal, the lockups happen with just X and Azaereus.
(The machine also runs mysqld, apache, and a few other daemons.  But I
don't have to put load on these to make the machine lock up.)


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/

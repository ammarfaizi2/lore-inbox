Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVDXDYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVDXDYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 23:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVDXDYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 23:24:00 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:61366 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S261300AbVDXDX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 23:23:57 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
	<1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
	<20050423170152.6b308c74.akpm@osdl.org> <87fyxhj5p1.fsf@blackdown.de>
	<1114308928.5443.13.camel@gaston>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
Date: Sun, 24 Apr 2005 05:14:04 +0200
In-Reply-To: <1114308928.5443.13.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sun, 24 Apr 2005 12:15:28 +1000")
Message-ID: <87acnokgsj.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2005-04-24 at 03:59 +0200, Juergen Kreileder wrote:
>
>> I'm might be the only one using evdev on ppc64.
>>
>> And I don't know how popular LVM2 is on disks with Macintosh
>> labels.  I had to set it up manually when I installed the machine,
>> Debian's installer couldn't handle it at that time.
>>
>> Workload is normal, the lockups happen with just X and Azaereus.
>> (The machine also runs mysqld, apache, and a few other daemons.
>> But I don't have to put load on these to make the machine lock up.)
>
> If you make sure you have CONFIG_XMON enabled and CONFIG_BOOTX_TEXT,
> and make sure X has "UseFBDev" option, do you drop into xmon before
> the lockup ?

I'll check that.

> Also, do you have another machine at hand ? if yes, then we can try
> to revive my old firewire based debug tools we used to track things
> down in linus tree.

I'd have to organize a firewire cable for that first.

> I'll have a look at the timer patch next week, they might have some
> subtle race caused by a lack of memory barrier. I've had to debug
> some of those in early timer code, and those are really nasty, they
> usually only trigger under some subtle conditions, like ... heavy
> networking.

I wouldn't call it "heavy" in my case.  Azareus uses quite a few
sockets but that isn't that uncommon and external traffic is limited
by a ADSL connection.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/

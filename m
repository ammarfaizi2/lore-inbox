Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTHZWlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTHZWjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:39:23 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:3341 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263077AbTHZWiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:38:17 -0400
Message-ID: <3F4BDD3A.4040703@boxho.com>
Date: Tue, 26 Aug 2003 18:20:42 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: how to log reiser and raid0 crash? 2.6.0-t4
References: <20030826102233.GA14647@namesys.com>	 <1061922037.1670.3.camel@spc9.esa.lanl.gov>	 <20030826182609.GO5448@backtop.namesys.com> <1061926566.1076.2.camel@teapot.felipe-alfaro.com> <3F4BBBB3.2080100@boxho.com>
In-Reply-To: <3F4BBBB3.2080100@boxho.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had syslog send just *.info to vc/5 and though the *.info messages 
never make
it into syslog file, I started cp -aR /usr/src/kernel-source-2.6.0 /tmp 
with md/2 mounted
to /tmp and saw this *.info on vc/5 and then it locked up.  How about 
those zeros, skip,
assign id anyway?

journal_1037: journal_read_transaction, offset 3623, len 0 mount_id 0
journal_1039: journal_read_trans skipping because 3623 is too old
journal_1299: Setting newest_mount_id to 12

Anything?

-Bob D

Resident Boxholder wrote:

> 2.6.0-test4 amd xp 3000+ msi mbo nforce2  four Maxtor 60G 8mbcache raid0
>
> I cause a lock up by doing a cp -aR /usr/src /mnt/usr which moves data 
> larger
> than total hard buffer cache, to raid0 reiserfs or ext2 ( NOT 
> reiser4!) Copy ops
> smaller than buffer cache(8mb x 4 = 32mb) don't fail. Nothing fails on 
> a single
> drive, compiles or copies, just copy to a mounted raid0 device. What 
> should I
> try, test, or dump?
>
> No irq error storm. No cd drives installed. Smaller copy ops work. 
> Turning
> swap off first slows things down enough to work, but swap itself is 
> probably
> OK. I have bios turn apic off, then linux turns it on, which is good 
> until the
> turn apic off before turn apic on patch gets into test5 or whatever.
>
> hdparm sets all four drives the same, udma6 but have tried down to udma4
> and pio4 and dma turned off, unmask on or off.
>
> If two drives are on the mboard controller and two on a promise pci card,
> does /proc/ide/amd74xx refer to the two drives on the motherboard only?
> It seems to mention four drives but the two slow ones might just be a
> ref to unoccupied slave drive positions.
>
> I'm wondering what to send in. Maybe I could send a log from successful
> copy with swap off, showing reiser logging, and config, in case a stress
> condition or misconfig shows up even when catastrophic failure doesn't
> occur. With swap on the fail is sudden and no error logging is coming
> through.
>
> I could incrementally copy /usr/src to one raid, then do a copy from that
> raid to another raid. All that would do is test copying from one balanced
> set of four drives/partitions to another balanced set, versus copying 
> from
> one drive's /usr/src to that and three other drives' raid set, which is
> unbalanced, dragging on one drive.
>
> -Bob
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


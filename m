Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWGEFkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWGEFkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWGEFkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:40:32 -0400
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:55172 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932366AbWGEFkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:40:32 -0400
Message-ID: <44AB5210.50501@wolfmountaingroup.com>
Date: Tue, 04 Jul 2006 23:45:52 -0600
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Bill Davidsen <davidsen@tmr.com>, Benny Amorsen <benny+usenet@amorsen.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com> <44AB4A68.90301@zytor.com>
In-Reply-To: <44AB4A68.90301@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Bill Davidsen wrote:
>
>>>
>>> DC> Easily doable in userspace, why bother with kernel programming
>>>
>>> In userspace you can't automatically delete the files when the space
>>> becomes needed. The LD_PRELOAD/glibc methods also have the
>>> disadvantage of having to figure out where a file goes when it's
>>> deleted, depending on which device it happens to reside on. Demanding
>>> read access to /proc/mounts just to do rm could cause problems.
>>>
>>> Userspace has had 10 years to invent a good solution. If it was so
>>> easy, it would probably have been done.
>>>
>> Actually, if it were so important it WOULD have been done. I suspect 
>> that the issue is not lack of a good solution, but lack of a good 
>> problem. The behavior you propose requires a lot of kernel 
>> cleverness, including make the inodes seem to go away, so the count 
>> is "right" for what the user sees.
>>
>
> The real solution for it is snapshots.


Peter,

Explain what you are thinking here.  What I proposed, I have already 
implemented in NetWare, it's very easy to do.  Snapshotting is not 
complex for FS's but does require a lot of space for meta-data to manage 
it.  EXT is not architecteced for something this complex.  A simple 
hidden mv is much easier to do.

Jeff

>
>     -hpa
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


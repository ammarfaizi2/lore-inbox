Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319002AbSHFGQu>; Tue, 6 Aug 2002 02:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319005AbSHFGQt>; Tue, 6 Aug 2002 02:16:49 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58635 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319002AbSHFGQs>; Tue, 6 Aug 2002 02:16:48 -0400
Message-ID: <2289.198.43.100.6.1028615479.squirrel@mail.zwanebloem.nl>
Date: Tue, 6 Aug 2002 08:31:19 +0200 (CEST)
Subject: Re: 2.4.18 (pre8) strange software raid0 problem
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <neilb@cse.unsw.edu.au>
In-Reply-To: <15693.5974.487891.772395@notabene.cse.unsw.edu.au>
References: <32838.192.168.0.100.1028462137.squirrel@mail.zwanebloem.nl>
        <15693.5974.487891.772395@notabene.cse.unsw.edu.au>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sunday August 4, faasen@xs4all.nl wrote:
>> Hi,
>>
>> i ran into a very strange problem.
>>
>> I booted my system this morning only to discover that I could no
>> longer mount my /dev/md0. I shut down my system last night without any
>> problems.
>>
>> The only way I can mount it again is with mdadm --assembly /dev/md0
>> /dev/sda9 /dev/sdb1 /dev/sdc1
>> I have to do this every time the system is rebooted.
>>
>> The distribution is debian unstable
>> mdadm - v1.0.1 - 20 May 2002
>> raidstart v0.3d compiled for md raidtools-0.90
>>
>> Is there any way to permanently fix this error?
>> How did this happen, as i didn't do anything i can see related to
>> this?
>
> Sounds to me like something changed in debian.  'unstable' is like that.

I can imagine you feel like that, but this was not the case.

> It would appear that you aren't using autodetect partitions, so you need
> to have either 'raidstart -a' or 'mdadm -As' run at boot time, with
> appropriate config files: /etc/raidtab or /etc/mdadm.conf.
> Check your rc scripts and config files, decide which one you want to
> use, and make sure the right script is enabled and the right
> configfile has appropriate information.
>
Well, that's just it, I was/am using autodetect partitions.
if I run raidstart -a or raidstart /dev/md0 it says something like "
strarting /dev/md0 succes!". However when I try to mount it it fails, only
the mdmadm command seems to work?

Tommy
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




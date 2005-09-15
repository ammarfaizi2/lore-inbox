Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVIOK1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVIOK1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVIOK1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:27:32 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:53214 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932548AbVIOK1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:27:32 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Hua Zhong <hzhong@gmail.com>, marekw1977@yahoo.com.au,
       linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Thu, 15 Sep 2005 03:26:40 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Automatic Configuration of a Kernel
In-Reply-To: <1126753444.13893.123.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0509150313500.9384@qynat.qvtvafvgr.pbz>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com><6bffcb0e05091415533d563c5a@mail.gmail.com><4328B710.5080503@in.tum.de><200509151009.59981.marekw1977@yahoo.com.au><924c288305091417375fea4ec2@mail.gmail.com><Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz>
 <1126753444.13893.123.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Lee Revell wrote:

> On Wed, 2005-09-14 at 19:03 -0700, David Lang wrote:
>> another advantage of having an auto-config for the kernel is that people
>> who are experimenting may have the auto-config find hardware that they
>> didn't realize they had (or they didn't realize that support had been
>> added)
>>
>> I know that most of my kernels don't have support for everything the
>> motherboards have on them (mostly I don't care much about the other
>> features, but in some cases they weren't supported, or weren't worth the
>> hassle of figureing the correct config for when I started, and I've never
>> gone back to try and figure it out)
>
> Why does this have to be in the kernel again?  Isn't this exactly what
> you get with a fully modular config and hotplug?

I happen to be one of those crazy people who believe that there are 
advantages to building non-modular kernels.

1. they compile faster

2. they use less memory (if tightly configured) as each module loaded will 
average a 1/2 page of wasted memory

3. it's far easier to moveone file around then a file and a directory tree 
of modules

4. the non-modular kernel will be slightly faster (all calls to modules 
must be far calls, if it's not modular the compiler can optimize some of 
the calls)

5. once kmem and mem can be made read-only there is a security advantage 
in not having kernel modules available (yes the machine can be rebooted 
into a new kernel, but that's easier to detect then a module getting 
loaded)

6. the kernel takes less space on disk (matters in embedded devices and 
other places where your media is small)

none of this matters if you're dealing with a large desktop system that 
you are installing from a series of CD/DVD disks from a top-5 distro, but 
that's not the entire world

note that a good autodetect routine will have no impact on the kernel once 
it's compiled, it just generates a .config file.

I believe it makes more sense to have this be part of the kernel source 
distro then a seperate project as it needs to have a lot of knowledge 
about what a particular kernel supports and that's going to change from 
release to release.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTFJQxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTFJQxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:53:49 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:42359 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263547AbTFJQxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:53:47 -0400
Message-ID: <3EE60F26.90409@rackable.com>
Date: Tue, 10 Jun 2003 10:02:30 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jordan Breeding <jordan.breeding@sbcglobal.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs vs rpm wierdness
References: <20030610164156.46888.qmail@web80110.mail.yahoo.com>
In-Reply-To: <20030610164156.46888.qmail@web80110.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 17:07:28.0486 (UTC) FILETIME=[C59FB060:01C32F72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:

>Try the following:
>
>`LD_ASSUME_KERNEL=2.4.5 rpm -qa` or whatever rpm
>command you need.  The recent 2.5.x (actually for a
>while) kernels have lots of changes to threading when
>used with the RedHat 9 glibc (which has nptl).  Using
>LD_ASSUME_KERNEL forces the new glibc to use the old
>threading stuff instead of something like that.  I
>read all of this on the RedHat 9 Beta mailing list and
>it seemes to work for me, it seems at some point
>RedHat will fix their berkley db and rpm packages to
>work with nptl and the newer 2.5.x kernels properly,
>they might even already be fixed in rawhide.
>
>Jordan
>

  That would appear to be my issue.  Thanks.  Sorry Reiserfs guys.

>
>--- Samuel Flory <sflory@rackable.com> wrote:
>  
>
>>  Anytime I try to install an rpm, or even run "rpm
>>-qa"  2.5.70, and RH 
>>9.   I get the following error.
>>
>>error: db4 error(22) from dbenv->open: Invalid
>>argument
>>error: cannot open Packages index using db3 -
>>Invalid argument (22)
>>error: cannot open Packages database in /var/lib/rpm
>>no packages
>>
>>
>>  If I reboot into redhat's 2.4.20-9 rpm works fine.
>> As far as I can 
>>tell there doesn't appear to be any file system
>>corruption.
>>
>>-- 
>>There is no such thing as obsolete hardware.
>>Merely hardware that other people don't want.
>>(The Second Rule of Hardware Acquisition)
>>Sam Flory  <sflory@rackable.com>
>>
>>
>>-
>>To unsubscribe from this list: send the line
>>"unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at 
>>http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



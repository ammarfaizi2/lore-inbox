Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUBJQK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUBJQK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:10:26 -0500
Received: from f19.mail.ru ([194.67.57.49]:49670 "EHLO f19.mail.ru")
	by vger.kernel.org with ESMTP id S265967AbUBJQKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:10:20 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Mike Bell=?koi8-r?Q?=22=20?= <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.204.70.139]
Date: Tue, 10 Feb 2004 19:10:16 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AqaSm-000BKQ-00.arvidjaar-mail-ru@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> I completely agree. But who would volunteer to spend their time fixing
> devfs if no one said they wanted devfs, if all evidence says everyone is
> happy with udev? I just wanted to get out that I'm not, I think devfs
> (as a concept, not neccessarily the implementation in the kernel right
> now) has merits udev does not and never will possess, and to see if anyone
> else agrees.

I am not happy with udev as it is currently; I am not happy with devfs crashing; I will continue to do what I can as time permits.

I do not neccessarily need devfs - but udev lacks two features I need and I do not see any way to add them without creatign the same sort of problems as devfs has.

>> Devfs can do this, but it is not necessarily a good thing.
>> I tried it - and it only works if someone tries to look up
>> a particluar name, such as /dev/dsp.  It doesn't work when someone
>> does a "ls /dev" to see what devices is there.
>> A "ls /dev/dsp*" didn't find the multiple soundcards for which
>> modules weren't yet loaded.
>

no way. this requires far deeper devfs integration that is currently available. there was code that did it for removable media; it was removed during 2.5 series. fixing bugs in devfs is one thing; reintegrating it into kernel is another.

basically devfs in 2.6 is reduced to

mknod from within drivers
devfsd notification on lookup

> Nor would you want it to... Although, it might be handy for something
> like a SCSI controller. An opendir() in its directory would trigger the
> kernel to see what's attached to it. Postponing the probing of every LUN
> until someone goes looking could speed up boot times quite a bit.

I must admit I never used devfs names myself so it proved rather useless to me even in 2.4 times.

-andrey


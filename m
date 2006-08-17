Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWHQD0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWHQD0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 23:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWHQD0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 23:26:21 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:30942 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751260AbWHQD0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 23:26:20 -0400
Date: Wed, 16 Aug 2006 23:26:30 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: Merging libata PATA support into the base kernel
In-reply-to: <200608102140.36733.rjw@sisk.pl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Stefan Seyfried <seife@suse.de>
Message-id: <44E3E1E6.9090908@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
 <200608102140.36733.rjw@sisk.pl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday 10 August 2006 21:02, Jason Lunz wrote:
>   
>> In gmane.linux.kernel, you wrote:
>>     
>>> You make it sound much worse than it is. Apart for HPA, I'm not aware of
>>> any setups that require extra treatment. And the amount of reported bugs
>>> against it are pretty close to zero :-)
>>>       
>
> No, it's not.
>
>   
>> *ahem*.
>>
>> I needed to do this to cure IDE hangs on resume:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
>>
>> Are you watching the suspend mailing lists? There's no shortage of them:
>>
>> suspend-devel:	http://dir.gmane.org/gmane.linux.kernel.suspend.devel
>> linux-pm:	http://dir.gmane.org/gmane.linux.power-management.general
>> suspend2-devel:	http://dir.gmane.org/gmane.linux.swsusp.devel
>> suspend2-users:	http://dir.gmane.org/gmane.linux.swsusp.general
>>
>> I'm currently trying to help out one Sheer El-Showk, whose piix ide
>> requires 30 seconds of floundering followed by a bus reset to resume:
>>
>> http://thread.gmane.org/gmane.linux.kernel.suspend.devel/276/focus=347
>>
>> But I know next-to-nothing about ATA.
>>
>> It's not surprising you're not getting many bug reports. It's common for
>> several things to go wrong during s2ram, and the user often ends up
>> looking at a hung system with a dead screen. It takes some quality time
>> with netconsole to even begin to narrow down that it's IDE hanging the
>> system, after which you can *begin* solving the no-video-on-resume
>> issue.
>>     
>
> I agree.  Moreover, the disk-related resume-from-ram problems are the hardest
> ones (the graphics may be handled from the user land to a reasonable extent).
>
> Actually, I'm looking for someone who'd agree to be Cced on bug reports where
> we suspect the problem may be related to IDE/PATA/SATA . ;-)
>
> Greetings,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Well it seems I am one of those users who is bit by the resume bug. I
was wondering why no developer has replied to my
bug(http://bugzilla.kernel.org/show_bug.cgi?id=6840) even though many
users have. Id try to fix it myself but Ive never done kernel hacking. I
haven't posted on the linux suspend lists because I talked to one of the
suspend2 developers who told me that the problem was with the ide driver
and thus could not help me.

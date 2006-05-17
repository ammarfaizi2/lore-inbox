Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWEQNkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWEQNkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEQNkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:40:42 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:41158 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932286AbWEQNkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:40:41 -0400
Message-ID: <446B27E4.7040509@cmu.edu>
Date: Wed, 17 May 2006 09:40:52 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-lvm@redhat.com
Subject: Re: need help booting from SATA in 2.4.32
References: <446A36B8.1060707@cmu.edu> <20060516203917.GQ11191@w.ods.org> <446A418E.3070307@cmu.edu> <20060517034814.GA25818@w.ods.org> <446B2523.1040800@cmu.edu> <20060517133456.GD23933@csclub.uwaterloo.ca>
In-Reply-To: <20060517133456.GD23933@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lennart Sorensen wrote:
> On Wed, May 17, 2006 at 09:29:07AM -0400, George Nychis wrote:
>> Good suggestion on disabling IDE, it does not show up as SATA, it simply
>> doesn't show up... after some googling, it seems as though no one has
>> gotten it as SATA in 2.4:
>> http://wip.powerblogs.com/posts/1124302626.shtml
>> http://www.linuxquestions.org/questions/showthread.php?t=400521
>>
>> Ok so, lets just assume we can't get SATA, and lets just try to get it
>> to boot as /dev/hda ... so now i know nothing about LVM, can anyone
>> provide me any insight on how to get this to boot with LVM?
>>
>> So in 2.6.9, it loads VolGroup00/LogVol00 from /dev/sda5 which shows up
>> in fdisk as LVM.  How can i get this to load from /dev/hda5 instead?
> 
> You don't.  SATA is using scsi style interface now, and with Alan Cox's
> current work, IDE drives soon will too.  It will all go through libata
> and show up as scsi disks.
> 
> It will be nice to have everything nice and consistent (except for the
> few oddball raid cards that insist on being completely different) for
> accessing disks.
> 
> SATA is not IDE, so why expect it to show up as an old style IDE disk?

Because it does......

on bootup the *same* exact drive in 2.4.32 shows up as /dev/hda

It has the exact same volume information as my drive that shows up in
2.6.9 as /dev/sda

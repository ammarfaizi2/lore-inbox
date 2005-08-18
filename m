Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVHRMtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVHRMtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHRMtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:49:02 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:20307 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932151AbVHRMtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:49:00 -0400
Message-ID: <430483BB.4090209@tls.msk.ru>
Date: Thu, 18 Aug 2005 16:48:59 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jeff shia <tshxiayu@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: can I write to the cdrom through writing to the device file sr0?
References: <7cd5d4b4050818014042740322@mail.gmail.com>	 <20050818100733.GA110@DervishD> <7cd5d4b40508180538133ca00f@mail.gmail.com>
In-Reply-To: <7cd5d4b40508180538133ca00f@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff shia wrote:
> thank you ,DervishD.
> another question:What is the difference between cdrtools and cdrecord?
> It seems that the fomer is bigger.

cdrtools is a package which includes cdrecord.  Or, the other
way 'round, cdrecord is a part of cdrtools package.  Nowadays,
anyway.

> On 8/18/05, DervishD <lkml@dervishd.net> wrote:
> 
>>   Hi Jeff :)
>>
>> * jeff shia <tshxiayu@gmail.com> dixit:
>>
>>>I want to write a cdrw user space driver just like cdreord,but the
>>>cdrecord is too complex and huge!can I write to the cdrom through
>>>writing to the device file sr0,here sr0 is the device file of the
>>>cdrw.
>>
>>   Although someone may say that the size of cdrecord is
>>proportional to the author's ego, the crude reality is that cdrecord
>>has to be such complex and huge (well, I don't think it is huge,
>>but...). It has to be complex because cdwriting *is* complex. Take a
>>look at the code and see if you can get rid of things. Nowadays I
>>think that most of the writers out there are SCSI-3/MMC compliant, so
>>you can just use that driver, but that won't probably remove much
>>code.

Well, yes and no.  If you have re-writable media, there's a packet
driver for it in recent kernels, and it is possible to (indirectly)
mount and use a cdrw device as normal block device.  Ofcourse it'll
only work for data "tracks", not for audio disks.

/mjt

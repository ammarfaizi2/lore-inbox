Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSFTVgi>; Thu, 20 Jun 2002 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFTVgh>; Thu, 20 Jun 2002 17:36:37 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4869 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315472AbSFTVgg> convert rfc822-to-8bit;
	Thu, 20 Jun 2002 17:36:36 -0400
Message-ID: <3D124ADF.6030103@evision-ventures.com>
Date: Thu, 20 Jun 2002 23:36:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
References: <Pine.LNX.4.44.0206201401010.8225-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Thu, 20 Jun 2002, Martin Dalecki wrote:
> 
>>>	/devices/disks/disk0 -> ../../pci0/00:02.0/02:1f.0/03:07.0/disk0
>>
>>                  ^^^^^^^^^^ You notice the redundancy in naming here :-).
> 
> 
> I'd rather have redundancy than have horrible names like just "0", thank
> you very much.
> 
> It takes up no space, all the dentries are virtual anyway, and a dentry
> embeds the storage for the first n characters (n ~16 or something like
> that).
> 
> 
>>Boah the chierachies are already deep enough. /devices/net/eth@XX
>>will cut it.
> 
> 
> There is _no_ excuse for being terse.

Yes indeed:

ls 	DIR
cp 	COPY
mv      REANME
cat     TYPE

Note: the VMS stuff was even longer. You ever used the "shell" there?

> Also, never EVER use special characters like "@" unless there is _reason_
> to use them. I don't see any reason to make a filesystem look like perl.

The reaons is that it is making the splitup betwen the enumeration
and naming part very easy. Not just for scripts but for C code as well.
Numbers get user quite frequently for versioning as well.
And I tought the above should be mainly used by programs?

> Please use sane names like "disknnn" over insane cryptographically secure
> filesystem contents like "sd@nnn".

I'm so used to sd@ :-). Don't invent where you can borrow - or you will
go the esperanto way.


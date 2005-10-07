Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVJGNaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVJGNaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVJGNaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:30:18 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:37462 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932547AbVJGNaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:30:16 -0400
Message-ID: <43467860.6090103@tls.msk.ru>
Date: Fri, 07 Oct 2005 17:30:08 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze (not even an OOPS) on remount-ro+umount when using
 quotas
References: <4346747C.2080903@tls.msk.ru>
In-Reply-To: <4346747C.2080903@tls.msk.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> This is something that has biten me quite successefully
> in last few days... ;)
> 
> To make a long story short:
> 
>  # mke2fs -j /dev/hda6
>  # mount -o usrquota /dev/hda6 /mnt
>  # cp -a /home /mnt                # to make some files to work with
>  # quotacheck -uc /mnt
>  # quotaon /mnt
>  # mount -o remount,ro             # this is the important step!

  # mount -o remount,ro /dev/hda6 /mnt
ofcourse... ;)

>  # ls -l /mnt /mnt/home            # to do "something" (also important)
>  # umount /mnt
> 
> At this time (attempting to umount the read-only filesystem with quotas
> enabled), the machine freezes without any messages on the console.  No
[...]

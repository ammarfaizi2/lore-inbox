Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269851AbUJMVRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269851AbUJMVRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269858AbUJMVRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:17:35 -0400
Received: from smtp18.wxs.nl ([195.121.6.14]:24731 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S269851AbUJMVP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:15:57 -0400
Date: Wed, 13 Oct 2004 23:16:34 +0200
From: Stef van der Made <svdmade@planet.nl>
Subject: Re: Gnome-2.8 stoped working on kernel-2.6.9-rc4-mm1
In-reply-to: <f44c5fdf041013134726043453@mail.gmail.com>
To: Radoslaw Szkodzinski <astralstorm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <416D9B32.5030408@planet.nl>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041011
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
 <416D8999.7080102@pobox.com> <Pine.LNX.4.58.0410131302190.31327@danga.com>
 <416D8C33.9080401@osdl.org> <416D923B.3030404@planet.nl>
 <f44c5fdf041013134726043453@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unpatching optimize-profile-path-slightly.patchsolved the issue. Thanks 
for the tip. You also gave the tip that I should compile without 
-fomit-frame-pointer. I've done this for years without any problem. What 
problems could this cause ?

Thanks again for your help,

Stef


Radoslaw Szkodzinski wrote:

>On Wed, 13 Oct 2004 22:38:19 +0200, Stef van der Made <svdmade@planet.nl> wrote:
>  
>
>>I'm trying to get kernel-2.6.9-rc4-mm1 to work with gnome-2.8. While
>>2.6.9-rc4 works fine with gnome-2.8 the mm1 version has an issue. Any
>>process that I'm trying to start that uses gnome libraries crashes
>>immediatly after startup. Mozilla, nautilus and gnome terminal to name a
>>few. The reason for using mm1 is that I'm using reiser4 for one of my
>>partitions.
>>
>>The output that I get in bugbuddy is as following:
>>
>>Backtrace was generated from '/usr/test/garnome2/lib/nautilus'
>>
>><snip>
>>    
>>
>This was useless, w/o any information.
>Next time please compile with debugging (-g) and without
>-fomit-frame-pointer. (in case of gcc <3.5)
>
>  
>
>>And on the terminal that I started X windows:
>>
>>"/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
>>/home/stef/405: No such file or directory.
>>/usr/local/mozilla/run-mozilla.sh: line 423:   460 Segmentation
>>fault      "$prog" ${1+"$@"}
>><snip>
>>/usr/local/mozilla/run-mozilla.sh: line 423:   483 Segmentation
>>fault      "$prog" ${1+"$@"}
>>
>>    
>>
>
>Looks like you need to back out this patch, the root of all evil:
>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
>like this:
>cd linux-2.6.9-rc4-mm1
>patch -p1 -R < /download-dir/optimize-profile-path-slightly.patch
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


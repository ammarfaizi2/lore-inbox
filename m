Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTL0PLg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 10:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTL0PLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 10:11:36 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:23818 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264469AbTL0PLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 10:11:34 -0500
Message-ID: <3FEDA124.5060503@ntlworld.com>
Date: Sat, 27 Dec 2003 15:11:32 +0000
From: Matt <dirtbird@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.4-6 StumbleUpon/1.87
X-Accept-Language: en, en-gb, ja
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FECD2FB.4070008@ntlworld.com> <1072485880.4136.1.camel@fur> <3FECDC9D.7020506@wmich.edu>
In-Reply-To: <3FECDC9D.7020506@wmich.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

> Rob Love wrote:
>
>> On Fri, 2003-12-26 at 19:31, Matt wrote:
>>
>>> If you are on debian i have noticed recently that gnomevfs (on 
>>> unstable) requires famd. famd will open /cdrom after it is mounted 
>>> and run a dir notification on it. now i think famd needs some 
>>> fixing, firstly to not bother running dir notice on ro filesystems, 
>>> and secondly allow an authorised user (other than the original 
>>> program (in this case nautilus)) to drop specific mount point dirs 
>>> from the notification list. so yes this is a userland problem as far 
>>> as i can see.
>>
>>
>>
>> Yup.
>>
>> But it sure is lame that our directory notification system (dnotify)
>> needs to hold open a file descriptor on the directory, and thus really
>> wrecks havoc on removable media.
>>
>> Would be nice to have a saner replacement - for other reasons, too.
>>
>>     Rob Love
>>
>>
>
> This may be true for mounted media, but people are having these 
> problems with audio cds too. And it doesn't explain why this never 
> happened with any of the test kernels.  does famd also mess with cds 
> that are loaded and not mounted?
>
>
Ack, just noticed that. I haven't seen famd messing with audio CDs, but 
also Joshua said that he didn't have famd installed on his machine, so 
that cuts that out. Strange how he said that eject(1) worked. Not sure, 
but just to reiterate to people though if you have mounted removable 
media it might not eject if you have famd installed on your machine, not 
sure if nautilus has been updated to drop its proxied dnotify when they 
are umounted.

    Matt



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTEFAfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTEFAfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:35:05 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:43697 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262210AbTEFAfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:35:02 -0400
Message-ID: <3EB7130D.6080802@blue-labs.org>
Date: Mon, 05 May 2003 21:42:37 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apcupsd-devel@apcupsd.org
Subject: Re: APC USB ups, Back-UPS ES series, 2.5.68
References: <3EB331B5.4080306@blue-labs.org> <20030503063632.GA2769@kroah.com> <3EB39463.2080307@blue-labs.org>
In-Reply-To: <3EB39463.2080307@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had time to look at it and try to debug it.  The 96 v.s. 192 
minor look like it's exactly 128 too high.  Perhaps it's a simple fix?

David

David Ford wrote:

> Yep...a simple fact that I overlooked.  This is a devfs created file 
> so the kernel is at fault.  Looks like it's off by 128.
>
>>>
>>> ~# ls -l /dev/usb/hid
>>> total 0
>>> crw-r--r--    1 root     root     180, 192 Dec 31  1969 hiddev96
>>> crw-r--r--    1 root     root     180, 193 Dec 31  1969 hiddev97
>>>   
>>
>>
>> Huh?  /dev/usb/hiddev0 is major 180, minor 96.  So the kernel asked for
>> minor 96 and it got it.  Why are you trying to connect to minor number
>> 192?
>


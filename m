Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbUJ0TuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUJ0TuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUJ0Tsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:48:31 -0400
Received: from delta.ece.northwestern.edu ([129.105.5.125]:508 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262656AbUJ0TlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:41:17 -0400
Message-ID: <417FFA38.8000602@ece.northwestern.edu>
Date: Wed, 27 Oct 2004 14:42:48 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: loopback on block device
References: <417FE703.3070608@ece.northwestern.edu> <Pine.LNX.4.61.0410271452390.4669@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410271452390.4669@chaos.analogic.com>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why /dev/ram0 is a file? Can you get into more details? For example, if 
I want to do some system level programming and write to a /dev/ram0, how 
do I do it?

Thanks very much for your reply!

Lei

linux-os wrote:

> On Wed, 27 Oct 2004, Lei Yang wrote:
>
>> Hello,
>>
>> Here is a question for loopback device. As far as I understand,  the 
>> loopback device is used to mount files as if they were block devices.
>>
>> Then Why I could do "losetup -e XOR /dev/loop0 /dev/ram0" ? Notice 
>> that ram0 is not mounted anywhere and does not have a filesystem on 
>> it. I've tried that command and there seems to be no error. I got 
>> confused and looked into loop.c, it seems to me that a loopback 
>> device should be associated with a "backing file", why would it work 
>> on a block device anyway?
>>
>> I'd appreciate your comments greatly!
>>
>> TIA,
>> Lei
>>
>
> `man losetup`
> You just set up the loop device to enable encryption on
> /dev/ram0. /dev/ram0 is a "file". It's a special-file,
> but a file nevertheless. It can contain a file-system,
> therefore act as a RAM disk, but it doesn't have to.
>
> In principle, you could make an encrypted file-system
> in which you couldn't even know what kind of file-
> system it was, without an encryption key.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached and reviewed by John Ashcroft.
>                  98.36% of all statistics are fiction.
>
>



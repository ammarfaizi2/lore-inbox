Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293433AbSCFJeg>; Wed, 6 Mar 2002 04:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293441AbSCFJeZ>; Wed, 6 Mar 2002 04:34:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46341 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293417AbSCFJeO>; Wed, 6 Mar 2002 04:34:14 -0500
Message-ID: <3C85E25C.6010304@evision-ventures.com>
Date: Wed, 06 Mar 2002 10:33:16 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: bitkeeper / IDE cleanup
In-Reply-To: <UTC200203052358.XAA187444.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> Andrew Morton writes:
> 
> 
>>fwiw, I prefer to not use bitkeeper, for the reasons which you outline.
>>
> 
> Seconded.
> 
> 
> Martin Dalecki writes:
> 
> : Disable configuration of the task file stuff.
> : It is going to go away and will be replaced by a truly abstract interface
> 
> Comment #1: Please observe the difference between cleanup and development.
>  I think your patches already went too far under the "cleanup" heading.

Plese note that the mail in wich I did send this particular patch didn't
contain the cleanup term. OK?

> Comment #2: We need a nice, general interface for the usual things,
>  and a very detailed direct-to-hardware interface for special purposes.
>  [Change the behaviour of a zip drive from "big floppy" to "removable disk"
>  and back. Take care of passwords on disks. Unstroke a 32+GB disk. Etc.]

Wen don't need "a nice general interface for the usual things". We need
the POSIX interface to them ;-).

However I agree that there is need for advanced features.
But first of all please notice that the
current "TASK FILE" code found there is not quite there. Second
please note that I would rather have a true lean *abstract* ioctl/sysctl
based interface to the really common things like spin down for example
and a tinny ioctl based interface for the people who love to break
hardware by software. Not quite what is there - the current taskfile
just tryes and fails (it's really hard to handle interrupts in user 
space) to map every single ATA-6 standard command to an ioctl().

The supposed validation of the commands prevents basically it's true
purpose as a back door for vendors loving to do things like controller
firmware updates through undefined commands.

I hope this makes my opinins clear.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293108AbSCFO4x>; Wed, 6 Mar 2002 09:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293627AbSCFO4n>; Wed, 6 Mar 2002 09:56:43 -0500
Received: from [195.63.194.11] ([195.63.194.11]:1289 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293108AbSCFO4c>;
	Wed, 6 Mar 2002 09:56:32 -0500
Message-ID: <3C862DE3.9090404@evision-ventures.com>
Date: Wed, 06 Mar 2002 15:55:31 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: bitkeeper / IDE cleanup
In-Reply-To: <E16icm7-00072w-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>3. Why do we have something like genric cdrom ioctl handling layer,
>>    which is basically just adding the above hooks?
>
> That bit is needed. You want unpriviledged processes to issue a subset of
> the available commands so users can do things like play music. Those ioctls
> for CDROM are also rather important for back compatibility.
> 
> Thats a seperate but important case.
> 
> There are two things I think you must consider
> 
> #1	"Make the simple things easy" - abstract common cd interface and
> 	friends. Unpriviledged but with strict limits on what can be issued
> 
> #2	"Make the hard possible" - the direct "I know what I am doing"
> 	CAP_SYS_RAWIO interface
> 
> #3	Ioctls that must be issued with kernel help because they change
> 	interface status and must synchronize both the device and the
> 	controller (eg 'go to UDMA3')
> 
> What can hopefully go is ioctls that are complex, setuid required and 
> could be done by #2.

Amen. I was of course not arguing against the cdrom abstraction layer.


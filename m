Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310821AbSCHMC7>; Fri, 8 Mar 2002 07:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310823AbSCHMCt>; Fri, 8 Mar 2002 07:02:49 -0500
Received: from [195.63.194.11] ([195.63.194.11]:13572 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310821AbSCHMCk>; Fri, 8 Mar 2002 07:02:40 -0500
Message-ID: <3C88A825.40000@evision-ventures.com>
Date: Fri, 08 Mar 2002 13:01:41 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Marko Kohtala <Marko.Kohtala@nokia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Removable IDE devices problem
In-Reply-To: <3C8895A9.9090705@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Kohtala wrote:
>  > Your analysis of the problem is entierly right, since the current
>  > kernel behaviour for removable media is supposed to work for
>  > floppies (never get this thing out of your computer
>  > as long as long the diode blinks) or read only media where it doesn't
>  > really matter. However I still don't see a good way to
>  > resolve this issue. (Maybe just adding buffer cache flush before
>  > going into the check_media_change business of "grocking" partitions
>  > would be sufficient...
> 
> But there is ide-floppy and ide-cd with their own media_check functions.
> 
> I'm thinking about ignoring the removable bit, at least when the device 
> does not have door lock. What would be hurt by it?

I have currently already just compared the ways invalidate_device() is
used in different linux block device drivers. And guess what... The way
it get's  currently used in ide code are bogous. This will changed soon
and should help your problems. (Soon means - if the weather doesn't
remain good over this weekend ;-). However please feel free to have a
look after this yourself.



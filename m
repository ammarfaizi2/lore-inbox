Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSHaTYF>; Sat, 31 Aug 2002 15:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSHaTYF>; Sat, 31 Aug 2002 15:24:05 -0400
Received: from mta11n.bluewin.ch ([195.186.1.211]:31919 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S317876AbSHaTYF>; Sat, 31 Aug 2002 15:24:05 -0400
Message-ID: <3D7117C3.5060307@linkvest.com>
Date: Sat, 31 Aug 2002 21:23:47 +0200
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMB browser
References: <3D709AB7.705@linkvest.com> <3D70A909.8080105@inet6.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>> Then the user access /smb/WG2/Machine38/Share12/Dir1/File2
>> Cool, no?
>
> I see some shortcomings :
>
> How will you handle multiple users ?
> Janice and Bob have accounts on the Linux client and both want to have 
> access at the same time to their [Home] for example :
> |-- DOM1 --|-- Machine4--|--[Home]


To access files on the server share, the client must send authentication 
tockens. This should be send by the daemon and must be get from a file 
on the disk that each user shuold have (the kerberos ticket got by PAM). 
If no file (or invalid one) is available, then it should be accessed as 
guest.

> How will you handle users with multiple logins on a Domain/Machine ? 

The user will already been logged on ONE domain controller.

> Maybe you'd be better starting with something like :
>
> local_user_home_directory--|--smb--|--login--|--WGx/DOMy--|.... 

I don't understand why a per-user directory tree should be needed. A 
per-machine tree should be enough.


This doesn't answer my question:
How do I communicate between a kernel driver and a userspace program?
What is the best method in terms of:
- simplicity (first implementation)
- efficacity (second implementation, performance oriented)
Is it viy UNIX sockets?
Is it ioctls?
Or shared memory?

Thanks.
-jec



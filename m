Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132901AbRDQWBj>; Tue, 17 Apr 2001 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132904AbRDQWBb>; Tue, 17 Apr 2001 18:01:31 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:45839 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S132901AbRDQWAz>; Tue, 17 Apr 2001 18:00:55 -0400
Message-ID: <3ADCBBA3.760C71CE@flying-brick.caverock.net.nz>
Date: Wed, 18 Apr 2001 09:54:46 +1200
From: viking <viking@flying-brick.caverock.net.nz>
Organization: The Flying Brick Computer
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@linux-fbdev.org>
CC: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Won't Power down (Was: More about 2.4.3 timer problems)
In-Reply-To: <Pine.LNX.4.10.10104170922070.2330-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:

> >Thanks, that solved my problem.  Have added it to the patch...
> >THe patch & 2.4.3 kernel seem to be working well, except that I can't get
> >PowerOff to kick in - it stops dead there, where it used to power down.
>
> Is this the case when the patch is removed as well. When does this occur
> exactly? After you load the module? Do you get any oops messages or does
> it just hang.

<comedy>
Module? What module?  I don't need no steenking module to power down.
I jest pull de plug outta de wall!
</comedy>

It has happened with both straight kernel, and patched.
Incidentally, Andrew, thanks for that patch. And thanks to
James Simmons too, for that Makefile fix.
I get (on a Mandrake 7.2+bits of 8 system) roughly:

Starting killall script [OK}
Setting hardware clock to system time  [OK]
Unmounting filesystems [OK]
The system is halted.   <===== issued by rc  script
Power Down.         <========= issued by printk

... and it stops there... instead of turning the power off like it did under
2.2.18 and earlier.
No kernel oops message.  Also, SysRq-O doesn't work - it just puts SysRq: up
on the screen.
The other SysRq functions  I've tried work - (Kill), (Sync), (reBoot).
Thanks for your continued monitoring.

--
 /|   _,.:*^*:.,   |\           Cheers from the Viking family,
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!




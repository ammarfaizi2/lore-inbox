Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSE2Onl>; Wed, 29 May 2002 10:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSE2Onk>; Wed, 29 May 2002 10:43:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62469 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315419AbSE2Oni> convert rfc822-to-8bit; Wed, 29 May 2002 10:43:38 -0400
Message-ID: <3CF4DA33.3030808@evision-ventures.com>
Date: Wed, 29 May 2002 15:40:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com> <20020529153504.C30585@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, May 29, 2002 at 03:03:27PM +0200, Martin Dalecki wrote:
> 
>>Dear Gerald please look closer. The hdparm -i is executing the
>>drive id command directly and does *not* rely on the internally
> 
> 
> hdparm -i uses the HDIO_GET_IDENTITY ioctl, which returns drive->id.
> It doesn't obtain the ID from the drive.  hdparm -I asks the
> identity from the drive.

Yes. But this will be just changed soon, since there
is no reaons at all to don't just read it always from the drive, in esp.
in face of the above.

BTW.> The above function was only used when the user
invoked ioctl() - that was my point.

> hdparm --help gives some hints:
> 
>  -i   display drive identification
>  -I   read drive identification directly from drive
> 
> and the man page is quite clear:
> 
>        -i     Display the identification info that  was  obtained
>               from the drive at boot time, if available.  This is
>               a feature of modern IDE drives, and may not be sup­
>               ported  by older devices.  The data returned may or
>               may not be current,  depending  on  activity  since
>               booting  the system.  However, the current multiple
>               sector mode count is  always  shown.   For  a  more
>               detailed interpretation of the identification info,
>               refer to AT Attachment Interface  for  Disk  Drives
>               (ANSI  ASC X3T9.2 working draft, revision 4a, April
>               19/93).
> 
>        -I     Request  identification  info  directly  from   the
>               drive,  which  is displayed in its raw form with no
>               endian changes or corrections.   Text  strings  may
>               appear mangled when using -I but that is NOT a bug.
>               Otherwise similar to the -i option.
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R


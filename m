Return-Path: <linux-kernel-owner+w=401wt.eu-S932311AbXAROlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbXAROlt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbXAROlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:41:49 -0500
Received: from stz-bg.com ([213.169.37.103]:57627 "EHLO stz-bg.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbXAROls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:41:48 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=stz-bg.com;
  b=ZGp0DsBzY7x63eyNLE8ZFdHdM0FlOtPph0n6IDNRJxxn1tdwhxWDr9BXF5NJte1Tafd45THUXBEHkrhorUFcKUXHP+qvW6Q3nfjQQsH56F/G928p0QPv9I6kKARolaYh  ;
Message-ID: <31333.83.228.43.37.1169131305.squirrel@mail.stz-bg.com>
In-Reply-To: <1169123236.12968.6.camel@localhost>
References: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
    <1169123236.12968.6.camel@localhost>
Date: Thu, 18 Jan 2007 16:41:45 +0200 (EET)
Subject: Re: PROBLEM: writting files > 100 MB in FAT32
From: "Condor" <condor@stz-bg.com>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Cc: linux-kernel@vger.kernel.org
Reply-To: condor@stz-bg.com
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2007-01-18 at 11:22 +0200, Condor wrote:
>> Hello,
>>
>> [1.] Files if > 100 MB saving in USB memory stick 4 GB with FAT32. While
>> saving all files is broken.
> im sorry, i do not understand this.
>
> you are saying that if you copy files larger than 100mb into drive, all
> files die?

No, only file when i copy is die.

>
>> [2.] I have USB memory stick A-DATA 4 GB with FAT32. When i trying to
>> save
>> files in my USB and files is > of 100 MB, all files that i save is
>> broken.
>> I put my USB in my laptop and mount it as: mount /dev/sda1 /mnt/usb-win
>> While i mount it, i got in my local disk and copy one file that is 520
>> MB.
>> The file is copying very slow (10 min). and after i see again my console
>> i
>> wait light to my usb is off and i unmount it as: umount /mnt/usb-win
>> I get my USB stick and when i return to home i trying to copy file from
>> my
>> USB to my windows and linux. Both OS unable to read file.
>> After some tryings i format my USB in FAT16 and now every thing is work
>> fine. I copy files to my USB and back to my hard drive and all files
>> work
>> fine.
>
> okay, i think thats what you are saying, could you please try to run
> dosfsck on it so we can see 100% whats wrong?
>

Yes, i run and it found error, i also run in windows scan drive, also
found errors. I't correct them and i make test again. After copy file
(unmount, sync ... ) i insert adapter again in windows and again unable to
copy file from usb to windows (linux say may be missing sectors, mount it
with read-only), run scan drive from windows and windows again found lost
sectors.

> also, try to do this:
> mount, copy, run command 'sync', unmount, pull out, and see if it works.
>

Yes this is that i make.

> finally, one more question. you said it does not work when you take it
> home, can you try this: mount, copy, unmount, mount, check to see if
> file works.
>

Yes i try one of the times and linux say may be sda1 have missing sectors
mount it with read-only.

>
>> [3.] lsmod
>> # lsmod
> <snip>
>> nvidia               4709172  22
> ohh, tainted ;P naughty. Though i dont think this affects vfat.
> <snip>
>
>> Regards,
>> Condor
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>

I no longer can make tests because i remove my fat32 from my usb stick and
i put it in to FAT16 and i make the exact tests and file is worked but on
fat16 not in fat32. I just report the problem, to be investigate from
kernel developers.


Regards,
Condor


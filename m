Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313896AbSDUVdx>; Sun, 21 Apr 2002 17:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSDUVdw>; Sun, 21 Apr 2002 17:33:52 -0400
Received: from lego.zianet.com ([204.134.124.54]:26895 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S313896AbSDUVdu>;
	Sun, 21 Apr 2002 17:33:50 -0400
Message-ID: <3CC32B57.1090703@zianet.com>
Date: Sun, 21 Apr 2002 15:12:55 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jordan.breeding@attbi.com
CC: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trouble rebooting Tyan Thunder K7 (S2462UNG)
In-Reply-To: <20020420130139.XUZR1901.rwcrmhc52.attbi.com@rwcrwbc55>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this motherboard too and have a similiar problem,
but it is usually not with reboots but with crashes.  I use
the nVidia graphics module which crashes time to time
and locks X, so I just hit the reset switch(Thank you
journalling fs).  But lots of times after I reboot it will
go through the initial POST, then go through the SCSI
detection, and 3ware detection, then when it should goto
the GRUB screen it will just display the POST screen
and hang, no beeps no nothing.  I usually have to power it
completely down for about a minute for it to come back
up right.  I have chalked this up to a BIOS problem though
and not a Linux one cause the BIOS should be smart enough
to pull it's head out of it's ass and reset any bad states that
may have been left behind. I would bitch to Tyan if I were you,
I have thought about it but never got up the energy.

Steve

jordan.breeding@attbi.com wrote:

>Hello,
>
>  Sorry about any duplicates of the last reply I sent 
>which might have gotten sent out, I am having to use 
>an online emailer right now and it seems to be 
>acting up.
>
>Jordan Breeding
>  
>
>>Sorry that I did not explain myself better the first time.  
>>The other OSes on this machine _do_ initialize a 
>>cold boot.  Here is how they _all_ reboot:  screen 
>>immediately goes black, hd light comes on as 
>>memory is ECC checked, hd light goes off and BIOS 
>>post screen comes up (monitor is now on again), 
>>Adaptec SCSISelect screen comes up, BIOS issues 
>>single beep and boots into GRUB.  This is the way 
>>that _all_ versions of linux reboot with _all_ reboot 
>>parameters:  screen hangs (but still has text on it, ie. 
>>the reboot messages) for at least 15-30 seconds, 
>>screen then goes blank, hd light comes on but _not_ 
>>for ecc check (during ecc check nothing is accessed 
>>except for memory) instead the system goes straight 
>>into SCSISelect once the screen goes blank and the 
>>hd light comes on (this is evident because during 
>>normal boot SCSISelect is the stage at which the hd 
>>light is on and each SCSI device is accessed in 
>>order), once SCSISelect has polled every id on the 
>>system it tries to hand back off to the BIOS which 
>>was apparently never initialized correctly during a 
>>Linux reboot since it issues a very weird series of 
>>eight or so BIOS beeps and then just sits there, the 
>>ecc memory is never polled, the BIOS post screen 
>>never comes up, the monitor never goes active 
>>again, the system is just hung at a black screen until 
>>I hard reboot it.  Other OSes _do_ perform a reboot 
>>in which ecc memory is polled however, so that 
>>does not seem to be the problem here.  Thanks for 
>>any more help anyone can offer.
>>
>>Jordan Breeding
>>    
>>
>>>On Fri, 2002-04-19 23:15:23 -0000, Jordan Breeding <jordan.breeding@attbi.com>
>>>wrote in message 
>>>
>>>      
>>>
>><!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjQHXypTRWUeX0Da3WGxUUMKAAAAQAAAA
>>    
>>
>>>b2jlXi9TM0a+IKeYbO47lAEAAAAA@attbi.com>:
>>>      
>>>
>>>>  I am having trouble getting a brand new Tyan Thunder K7 S2462UNG (the
>>>>one with onboard SCSI) to reboot successfully using Linux.  This board
>>>>        
>>>>
>>>>FreeBSD do with this board, instead the text stays there for at least
>>>>15-20 seconds (maybe longer) then when it finally blanks the video and
>>>>the monitor light begins to flash it goes straight into the Adaptec
>>>>SCSISelect scan (I can tell because my HD light comes on and the CDROMs
>>>>        
>>>>
>>>What is so uncommon? The board does use ECC RAM, so maybe the board's
>>>BIOS / firmware needs this time to blank and check all the RAM. Maybe
>>>othe OSes don't initiate a full "cold boot" but something that doesn't
>>>make the board to re-initialize all the RAM...
>>>
>>>MfG, JBG
>>>
>>>-- 
>>>Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
>>>	 -- New APT-Proxy written in shell script --
>>>	   http://lug-owl.de/~jbglaw/software/ap2/
>>>
>>>      
>>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>




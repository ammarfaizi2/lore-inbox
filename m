Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSHAVSO>; Thu, 1 Aug 2002 17:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSHAVSO>; Thu, 1 Aug 2002 17:18:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35083 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317107AbSHAVSN>; Thu, 1 Aug 2002 17:18:13 -0400
Message-ID: <3D49A532.1090606@evision.ag>
Date: Thu, 01 Aug 2002 23:16:34 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.29 IDE 110
References: <C917933AE2@vcnet.vc.cvut.cz>  <3D499862.6070305@evision.ag> <1028238427.14871.95.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Alan Cox napisa³:
> On Thu, 2002-08-01 at 21:21, Marcin Dalecki wrote:
> 
>>Maybe not a loop device? But how about handling this at partition scan
>>time then? Partitions are after all nothing else then devices
>>with remapped sectors in first place. Could you manage to insert
>>at the proper place in paritions/*.c the magical + 1.
>>It could then be turned in no instant in to a global kernel
>>option - whch it what it is after all.
> 
> 
> Is there any reason this can't be dumped on LVM2 and/or EVMS whichever
> gets in ?

Lets not forgett that the code removed would allow to read behind the
partion in question and was broken therefore. However the real world
example from Petr worries me and makes me thinking that the partition
scanning time solution could turn out to be most adequate -> we have the
FAT partition ID there at hand and could adjust the partition
parameters in question properly with ease. Both of them: offset *and* size.

Petr would you mind dumping the dd=/dev/hdx count=10 of the
disk in question at me? Or do you preferr to go after this blotch
yourself?


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSHHHcU>; Thu, 8 Aug 2002 03:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHHHcU>; Thu, 8 Aug 2002 03:32:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6410 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316204AbSHHHcT>;
	Thu, 8 Aug 2002 03:32:19 -0400
Message-ID: <3D521E07.8070908@evision.ag>
Date: Thu, 08 Aug 2002 09:30:15 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andries.Brouwer@cwi.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, (not IDE)] partition table (not) corruption?
References: <Pine.LNX.4.44.0208072309320.5699-100000@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Ingo Molnar napisa?:
> On Wed, 7 Aug 2002 Andries.Brouwer@cwi.nl wrote:
> 
> 
>>LILO without "linear" or "lba32" is inherently broken: it will talk CHS
>>at boot time to the BIOS and hence needs a geometry and install time,
>>and nobody knows the geometry required. So, if LILO doesnt break, this
>>is pure coincidence.
> 
> 
> well, lilo without linear worked for like years on this box ...

You have to take in to account that by creating a new kernel image
you are storing it sometimes after a long long time at perhaps maybe
another block group far away.  This is becouse ext2 suddenly may feel
like doing so...And surprisingly you have to teach lilo about the new
far away sectors becouse basic C/H/S addressing can't reach them
anylonger. Been there seen that frequently enough.

It would be maybe informative if you could actually provide the
first sector address used by the inode corresponding to vmlinuz.
At least this way one could resolve the issue definitively.

>>And you talk about corruption, and I am surprised again. Have you
>>verified that there really was a difference? Or do you only suspect
>>corruption because LILO has problem? (In that case I can assure you that
>>there was no corruption.)
> 
> 
> you are right, there was no corruption most likely. And the IDE subsystem
> is most definitely innocent.

I have told you :-).

BTW.> Please don't consider RH lilo "fairly standard" it *is* messing
with the geometry issues, since in esp. limbo.


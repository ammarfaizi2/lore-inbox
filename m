Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317617AbSFMOSX>; Thu, 13 Jun 2002 10:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317618AbSFMOSW>; Thu, 13 Jun 2002 10:18:22 -0400
Received: from jalon.able.es ([212.97.163.2]:15490 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317617AbSFMOSW>;
	Thu, 13 Jun 2002 10:18:22 -0400
Date: Thu, 13 Jun 2002 16:18:09 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Braden McGrath <bwm3@po.cwru.edu>
Cc: "'Samuel Flory'" <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot withPromise 20267
Message-ID: <20020613141809.GA2296@werewolf.able.es>
In-Reply-To: <006f01c21258$b72a7430$ceaa1681@z>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.12 Braden McGrath wrote:
>>   You might try Alan Cox's ac kernel.  2.4.19pre10ac2 seems 
>> to work bit better on the Promise controllers for me.  You 
>> will need to patch in 2.4.19pre10, and then 2.4.19pre10ac2.
>> 
>> http://www.us.kernel.org/pub/linux/kernel/v2.4/testing/
>>
>http://www.us.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/
>
>Thanks, I'll give it a try... Will I experience any problems trying to
>get XFS into this kernel as well?  I start with 2.4.18 to patch to the
>pre* series, correct?  (I'm not used to running bleeding edge...)  I'm
>guessing the order would be:
>2.4.18 (stock)
>+XFS
>+.19pre10
>+pre10ac2

If you want the changes present in pre10 _and_ xfs _and_ LVM,
get the -aa kernel. Version pre10-aa2 has xfs included.
You can get the original at

http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa2.gz
http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa2/

Or a copy at:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre10-jam2/00-aa-pre10aa2.bz2

I talk about the copy because in the same location you also have Andre's
ide-convert.10 IDE update patch:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre10-jam2/40-ide-10.bz2

You can try with those patches to see if this gives any help (note: IDE's patch
is not the original, it has been edited to merge with -aa, so I can have made
a mistake -- if it works someone could give it a thorough test, I have not
the hardware...)


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)

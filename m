Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTFTKXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTFTKXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:23:25 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:59615 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262720AbTFTKXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:23:12 -0400
Message-ID: <3EF2E3D5.90908@inet6.fr>
Date: Fri, 20 Jun 2003 12:37:09 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SIS IDE] Enhanced SiS96x support
References: <3EF0FC4E.4090805@inet6.fr> <20030620092613.A13834@ucw.cz>
In-Reply-To: <20030620092613.A13834@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Vojtech Pavlik wrote:

>On Thu, Jun 19, 2003 at 01:57:02AM +0200, Lionel Bouton wrote:
>  
>
>>Hi,
>>
>>you'll find attached a patch against 2.4.21-ac1 for the SiS IDE driver.
>>
>>This is a 99% Vojtech work :
>>- Independant southbridge detection (no need to add MuTIOL northbridge 
>>PCI ids to the driver),
>>- Lots of code cleanup,
>>- Debug code removed (unused for a while, I will maintain it in my tree 
>>if needed),
>>
>>I changed 2 things :
>>- SiS745 was reported to me as a MuTIOL northbridge chip, it is treated 
>>as such by removing it from the integrated chip table,
>>    
>>
>
>Look at http://www.sis.com/products/chipsets/oa/socketa/745.htm
>The chip has internal MuTIOL, but no 961/2/3 chip can be connected
>to it. I'm not sure, of course, whether the internal IDE of this chip
>behaves like a 961/2/3, though.
>  
>

The SiS chipset line can be quite confusing :

- the 730 was roughly a 735 with integrated video,
- the 740 is a pure northbridge with integrated video whereas the 745 
docs mention MuTIOL (usually a hint for separated north/south bridges) 
but the southbridge is still integrated and seems to be ATA100 like the 
735. I hope there isn't any 745 revision with different capabilities I'm 
not yet aware of...

I'll post a one liner this evening or a full patch if Alan and/or Linus 
didn't already patch their tree.

LB.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbTI2LSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTI2LSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:18:16 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:57042 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S263072AbTI2LSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:18:14 -0400
Message-ID: <3F7814F2.80405@inet6.fr>
Date: Mon, 29 Sep 2003 13:18:10 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>,
       Michael Frank <mhf@linuxmail.org>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262208.30582.mhf@linuxmail.org> <yw1x3cejlk34.fsf@users.sourceforge.net> <200309262332.30091.mhf@linuxmail.org> <20030926165957.GA11150@ucw.cz> <yw1x7k3vjw8o.fsf@users.sourceforge.net> <20030926175358.GA12072@ucw.cz>
In-Reply-To: <20030926175358.GA12072@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik said the following on 09/26/2003 07:53 PM:

>On Fri, Sep 26, 2003 at 07:27:35PM +0200, M?ns Rullg?rd wrote:
>  
>
>>Vojtech Pavlik <vojtech@suse.cz> writes:
>>
>>    
>>
>>>Actually, it's me who wrote the 961 and 963 support. It works fine for
>>>most people. Did you check you cabling?
>>>      
>>>
>>I'm dealing with a laptop, but I suppose I could wiggle the cables a
>>bit.  I still doubt it's a cable problem, since reading works
>>flawlessly.
>>    
>>
>
>Hmm, that's indeed interesting and it'd point to a driver problem -
>when reading, the drive is dictating the timing, but when writing, it's
>the controllers turn.
>
>So if the controller timing is not correctly programmed, reads function,
>but writes don't.
>
>Can you send me the output of 'lspci -vvxxx' of the IDE device?
>I'll take a look to see if it looks correct.
>
>  
>
>>It appears to me that during heavy IO load, some DMA interrupts get
>>lost, for some reason.
>>    
>>
>
>Well, I've got this feeling that not just IDE interrupts get lost under
>heavy IO load with recent kernels ...
>
>  
>

This could explain some odd reports. Amongst the usual causes like flaky 
hardware, kernel misconfiguration and the likes, I encountered some 
people for which IO-APIC support would throw their data away...

Now I always ask the users to recompile without IO-APIC, this usually 
brings other problems (awful ethernet perfs for one user comes to my 
mind) but tends to solve IDE instability.

Until today, I've not a single report where lspci -vxxx highlighted any 
IDE register misconfiguration, AFAICS your code *is* correct Vojtech.

LB.

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 



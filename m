Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTDURhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTDURhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:37:25 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:5636 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261798AbTDURhW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:37:22 -0400
Message-ID: <3EA43080.70204@kolumbus.fi>
Date: Mon, 21 Apr 2003 20:55:12 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
References: <200304210351_MC3-1-3544-3713@compuserve.com> <Pine.LNX.4.50.0304211008110.2085-100000@montezuma.mastecende.com> <3EA41684.6030502@kolumbus.fi> <Pine.LNX.4.50.0304211314040.2085-100000@montezuma.mastecende.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 21.04.2003 20:50:24,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 21.04.2003 20:50:00,
	Serialize complete at 21.04.2003 20:50:00
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes the current code has the assumption of 1to1 mapping from vector to 
irq, but that's a software limitation.

--Mika


Zwane Mwaikambo wrote:

>On Mon, 21 Apr 2003, Mika Penttilä wrote:
>
>  
>
>>Why can't we use the same vector for multiple ioapic entrys? After all, 
>>we are already sharing irqs, and an irq is just a cookie for a vector. 
>>What do you mean with "lost irq routing" ?
>>    
>>
>
>Each ioredtbl can take a vector, if you assign another ioredtbl with the 
>same vector and different IRQ then you collide with the previous entry and 
>wipe it from the IDT. Also irq != vector
>
>	Zwane
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



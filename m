Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTELSfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTELSfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:35:32 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:22284 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261500AbTELSfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:35:31 -0400
Message-ID: <3EBFEDD1.2060904@kolumbus.fi>
Date: Mon, 12 May 2003 21:54:09 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: willy@debian.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru
Subject: Re: Message Signalled Interrupt support?
References: <20030512163249.GF27111@gtf.org>	<20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk> <20030512.102023.71099561.davem@redhat.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 12.05.2003 21:49:18,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 12.05.2003 21:48:53,
	Serialize complete at 12.05.2003 21:48:53
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that  MSI should be made quite explicit. If the device and 
platform both support MSI, then the driver should be able to ask for 
MSI, but kernel must be able to deny it. All devices supporting MSI must 
support also pin based interrupt delivery. As MSI can be costy (one 
interrupt vector per device for instance), it could be that a device has 
to work in pin based mode instead.

--Mika


David S. Miller wrote:

>   From: Matthew Wilcox <willy@debian.org>
>   Date: Mon, 12 May 2003 17:53:31 +0100
>
>   On Mon, May 12, 2003 at 12:32:49PM -0400, Jeff Garzik wrote:
>   > Has anybody done any work, or put any thought, into MSI support?
>   
>   Work -- no.  Thought?  A little.  Seems to me that MSIs need to be
>   treated as a third form of interrupts (level/edge/message).
>
>The fact that Alpha already supports them pretty much transparently
>suggests that the thing to do might very well be "nothing" :-)
>
>To be honest, MSIs are very similar to how interrupts work on sparc64,
>in that each device generates a unique interrupt cookie.  The only
>different is the size of this cookie, MSIs are larger than sparc64's.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



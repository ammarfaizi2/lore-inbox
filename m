Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUCHR5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUCHR5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:57:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49908 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262639AbUCHR5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:57:12 -0500
Message-ID: <404CB3F0.2020701@mvista.com>
Date: Mon, 08 Mar 2004 09:57:04 -0800
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
References: <40462AA1.7010807@mvista.com> <20040305220950.GA5352@openzaurus.ucw.cz>
In-Reply-To: <20040305220950.GA5352@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:

>Hi!
>
>  
>
>>(PRAMFS). It was originally developed for three major consumer
>>electronics companies for use in their smart cell phones
>>and other consumer devices.
>>
>>An intro to PRAMFS along with a technical specification
>>is at the SourceForge project web page at
>>http://pramfs.sourceforge.net/. A patch for 2.6.3 has
>>been released at the SF project site.
>>    
>>
>
>Well, I'd certainly love to see some usable linux cell phones. 
>(Well, one such beast in my pocket would probably be enough :-)
>(Is there a way to make linux cell phone without second
>cpu just for GSM stack?)
>

one of the chips used in their cell phones is the TI OMAP1510.
It has an embedded TMS320c55 DSP as well as an ARM 925.

>
>Comments about pramfs: RAM is not really random access,
>you'll find that doing byte-sized random reads is way slower
>than linear read,
>but you are right that it is very different from disk.
>
>
>How do you handle powerfail in the middle of write?
>

good question, I don't - not in software anyway. But the companies
I mentioned may have implemented some kind of h/w safe shutdown,
but I'm not sure.

>Do you run fsck or do you have some kind of logging?
>

If you mean journaling, no, pramfs is not a journaling fs.

And you're right, I still need to write an fsck for pramfs.
At this point there is no way to recover a corrupt fs.

Steve



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293672AbSCPC0W>; Fri, 15 Mar 2002 21:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293673AbSCPC0L>; Fri, 15 Mar 2002 21:26:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293672AbSCPC0C>;
	Fri, 15 Mar 2002 21:26:02 -0500
Message-ID: <3C92AD1F.30909@mandrakesoft.com>
Date: Fri, 15 Mar 2002 21:25:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <Pine.LNX.4.33.0203151659060.1379-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Sat, 16 Mar 2002, Anders Gustafsson wrote:
>
>>this patch fixes "undefined reference to `local symbols in discarded
>>section .text.exit'" linking error.
>>
>
>Looking more at this, I actually think that the _real_ fix is to call all
>drivers exit functions at kernel shutdown, and not discard the exit
>section when linking into the tree.
>
>That, together with the device tree, automatically gives us the
>_correct_ shutdown sequence, soemthing we don't have right now.
>
>Anybody willing to look into this, and get rid of that __devexit_p()
>thing?
>

(thinking vaguely long-term)

I wonder if mochel already code for this, or has thought about this... 
 Just like suspend, IMO we ideally should use the device tree to 
shutdown the system, agreed?

Further, I wonder if the reboot/shutdown notifiers can be replaced with 
device tree control over those events...

    Jeff







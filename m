Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264574AbSIQWNl>; Tue, 17 Sep 2002 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264605AbSIQWNl>; Tue, 17 Sep 2002 18:13:41 -0400
Received: from ns1.cypress.com ([157.95.67.4]:17840 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264574AbSIQWNk>;
	Tue, 17 Sep 2002 18:13:40 -0400
Message-ID: <3D87AA0D.6040600@cypress.com>
Date: Tue, 17 Sep 2002 17:17:49 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Rogier Wolff <R.E.Wolff@bitwizard.nl>, gen-lists@blueyonder.co.uk,
       linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net> <3D878788.2030603@cypress.com> <20020917125817.B11583@one-eyed-alien.net> <3D878CF7.3040304@cypress.com> <1032297193.1276.23.camel@stimpy.angelnet.internal> <20020917235822.C26741@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rogier Wolff wrote:
> On Tue, Sep 17, 2002 at 10:13:13PM +0100, Mark C wrote:

> When dd is told to skip a certain number of input blocks it doesn't
> seek past them, but reads them and then discards them. Thus if you're
> not supposed to read sectors 1-100 then this will not work. 

Fair enough. I, and the others though it did a seek.


> Try the following program: 
<snip>
> with the command: 
> 
> 	dd if=/dev/sda of=firstpart 
> 
> (Get the partition table)
> 
> 	(seek 0x100000;dd of=secondpart) < /dev/sda 
> 
> Get everything beyond 1Mb. If this works, then we have to figure out
> how low we can make the "0x100000" number to get all of the data.
> 
> Hypothesis: The partition table specifies that the data starts
> on sector 200, and they didn't implement sectors 1-199.....

Where did the sector 200 come from?
Something in the dmesg output from before?
(I don't really grok SCSI or USB at that level :( )

> Cheap basterds. 

Agree:)

	-Thomas


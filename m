Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310176AbSCPIwQ>; Sat, 16 Mar 2002 03:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310178AbSCPIwG>; Sat, 16 Mar 2002 03:52:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310176AbSCPIvy>;
	Sat, 16 Mar 2002 03:51:54 -0500
Message-ID: <3C930785.2070902@mandrakesoft.com>
Date: Sat, 16 Mar 2002 03:51:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 15 Mar 2002, Jeff Garzik wrote:
>
>>I wonder if mochel already code for this, or has thought about this... 
>> Just like suspend, IMO we ideally should use the device tree to 
>>shutdown the system, agreed?
>>
>
>Ideally we should, yes. Although if we really turn off power, it doesn't 
>much matter.
>
It matters to a software engineering wonk like me :)   I know it 
-really- doesn't matter, but from a theoretical perspective, if we are 
trying to achieve the "everything is hotpluggable" model, poweroff via 
device tree will naturally fall out from that.

If it makes it easier for some, I consider poweroff not as an act unto 
itself, but as a transition to state D3cold. :)  And since we will 
eventually be able to handle transition to similar low-power states, we 
might as well follow similar/the same code paths.

>>Further, I wonder if the reboot/shutdown notifiers can be replaced with 
>>device tree control over those events...
>>
>
>This is what I want. Those reboot/shutdown notifiers are completely and 
>utterly buggy, and cannot sanely handle any kind of device hierarchy.
>
yep

    Jeff






Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291096AbSBLOwi>; Tue, 12 Feb 2002 09:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291093AbSBLOw3>; Tue, 12 Feb 2002 09:52:29 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:46350 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S291092AbSBLOwU>; Tue, 12 Feb 2002 09:52:20 -0500
Message-ID: <3C692C1C.7090107@roanoke.edu>
Date: Tue, 12 Feb 2002 09:52:12 -0500
From: "David L. Parsley" <parsley@roanoke.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Stefan Rompf <srompf@isg.de>, linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de.suse.lists.linux.kernel> <p73g0525je4.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (penguin.roanoke.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

> In short - Linux doesn't have this feature because it's not needed.
> If your routing protocol relies on link state checking without other
> probing it's broken. Zebra isn't. 

Link state checking _would_ be nice, though, for stuff like laptops 
using dhcp.  Right now, if I start my laptop without being plugged into 
the network, I have to wait for DHCP to time out before it'll finish 
booting - about 1 minute.  (yech!)

Is there a good way for a dhcp daemon to find out whether the laptop is 
connected to the network or not?  It'd be really sweet if dhcpcd could:

- down the interface and remove routes whenever the network cable was 
unplugged
- wait for the interface to get link beat again, and send a new request

This would greatly enhance desktop usability.  I'd be happy to do the 
dhcpcd hacking if the right kernel interfaces were available.

regards,
	David

-- 
David L. Parsley
Network Administrator, Roanoke College
"If I have seen further it is by standing on ye shoulders of Giants."
--Isaac Newton


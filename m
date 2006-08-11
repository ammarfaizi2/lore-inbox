Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWHKT67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWHKT67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHKT67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:58:59 -0400
Received: from exchfe1.cs.cornell.edu ([128.84.97.27]:63669 "EHLO
	exchfe1.cs.cornell.edu") by vger.kernel.org with ESMTP
	id S964771AbWHKT6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:58:55 -0400
Message-ID: <44DCE1FD.5020901@cs.cornell.edu>
Date: Fri, 11 Aug 2006 16:01:01 -0400
From: Alan Shieh <ashieh@cs.cornell.edu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Rodrick <daniel.rodrick@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>	 <44D7579D.1040303@zytor.com>	 <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>	 <44D76F26.9@zytor.com>	 <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>	 <44D8A80F.1020202@cs.cornell.edu> <292693080608100118rc910647l7a8bf95fbc2df26c@mail.gmail.com>
In-Reply-To: <292693080608100118rc910647l7a8bf95fbc2df26c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2006 19:58:52.0065 (UTC) FILETIME=[9177D110:01C6BD80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm ... pardon me if I am wrong, but I think you implemented a "UNDI
> Driver" (i.e. the code that provides implementation of UNDI API, and
> often resides in the NIC ROM) . I'm looking forward to write a
> "Universal Protocol Driver" (i.e. the code that will be a linux kernel
> module and will, use the UNDI API provided by your UNDI driver).

I wrote a universal protocol driver that runs in Linux, and talks to an 
extended UNDI stack implemented in Etherboot.

>> At minimum, one needs to be able to probe for !PXE presence, which means
>> you need to map in 0-1MB of physical memory. The PXE stack's memory also
>> needs to be mapped in. My UNDI driver relies on a kernel module, generic
>> across all NICs, to accomplish these by mapping in the !PXE probe area
>> and PXE memory in a user process.
> 
> 
> I'm pretty newbie to PXE, but I I think !PXE structure is used to find
> out the location & size of PXE & UNDI runtime routines, by UNIVERSAL
> PROTOCOL DRIVERS. Is my understanding wrong?

That's right.

> Also, I think that UNDI driver routine will need not call PXE routines
> (TFTP / DHCP etc) as UNDI routines would be at a lower level providing
> access to the bare bones hardware. Is this correct?

I'm calling the UNDI level routines (packet send, interrupt handling) 
from my driver.

Alan

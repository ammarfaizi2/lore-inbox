Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293375AbSBYK7N>; Mon, 25 Feb 2002 05:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293376AbSBYK7D>; Mon, 25 Feb 2002 05:59:03 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:55570 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S293375AbSBYK6s>; Mon, 25 Feb 2002 05:58:48 -0500
Message-ID: <3C7A189F.8871B328@aitel.hist.no>
Date: Mon, 25 Feb 2002 11:57:35 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.4-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
In-Reply-To: <200202221557.g1MFvp004149@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
[...]
> Unfortunately, there's actually a hole in the SCSI spec that means ordered
> tags are actually extremely difficult to use in the way you want (although I
> think this is an accident, conceptually, I think they were supposed to be used
> for this).  For the interested, I attach the details at the bottom.
> 
[...]
> The SCSI tag system allows all devices to have a dynamic queue.  This means
> that there is no a priori guarantee about how many tags the device will accept
> before the queue becomes full.
> 

I just wonder - isn't the amount of outstanding requests a device
can handle constant?  If so, the user could determine this (from spec or
by running an utility that generates "too much" traffic.)  

The max number of requests may then be compiled in or added as
a kernel boot parameter.  The kernel would honor this and never ever
have more outstanding requests than it believes the device
can handle.  

Those who don't want to bother can use some low default or accept the
risk.

Helge Hafting

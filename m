Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275365AbTHMTrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275352AbTHMTqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:46:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275342AbTHMTo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:44:58 -0400
Message-ID: <3F3A952C.4050708@pobox.com>
Date: Wed, 13 Aug 2003 15:44:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk>
In-Reply-To: <20030813193855.E20676@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Aug 13, 2003 at 02:26:11PM -0400, Jeff Garzik wrote:
> 
>>Again, my philosophy:  put the data in its most natural form.  In 
>>CS-speak, domain-specific languages.  So, just figure out what you want 
>>the data files to look like, and I'll volunteer to write the parser for it.
> 
> 
> But what's the point of the extra complexity?  People already put
> references to other structures in the driver_data element, and
> enums, so completely splitting the device IDs from the module
> source is not going to be practical.

enums are easy  putting direct references would be annoying, but I also 
argue it's potentially broken and wrong to store and export that 
information publicly anyway.  The use of enums instead of pointers is 
practically required because there is a many-to-one relationship of ids 
to board information structs.


> Are you thinking of a parser which outputs C code for the module to
> include?  That might be made to work, but it doesn't sound as elegant
> as the solution being described previously in this thread.
> 
> "Make the easy things easy (PCI_DEVICE(vendor,device)) and make the
> not so easy things possible (the long form)"

That ignores the people who also need to get at the data, which must 
first be compiled from C into object code, then extracted via modutils, 
then turned into a computer readable form again, then used.

	Jeff




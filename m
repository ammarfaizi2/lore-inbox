Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272214AbRHWIA3>; Thu, 23 Aug 2001 04:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272218AbRHWIAU>; Thu, 23 Aug 2001 04:00:20 -0400
Received: from t2.redhat.com ([199.183.24.243]:5371 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272214AbRHWIAJ>; Thu, 23 Aug 2001 04:00:09 -0400
Message-ID: <3B84B818.6F7E7139@redhat.com>
Date: Thu, 23 Aug 2001 09:00:24 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell inspiron 8000 eepro100 problems
In-Reply-To: <71714C04806CD51193520090272892178BD4F3@ausxmrr502.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> 
> > i'm using 2.4.9 and have had a problem since 2.2
> > kernels along with all versions of 2.4. i am having a
> > problem with 2 laptops, both are dell inspiron 8000
> > that have intel 82557 mini-pci nic in them. i get no
> 
> <Not official support>
> 
> Is the "sleep mode bit" set on the NIC?  Please try Donald Becker's
> eepro100-diag.c program, located at
> ftp://ftp.scyld.com/pub/diag/eepro100-diag.c, and use the -G -w -w -w flags
> to clear that bit if running it first says that the sleep bit is enabled.
> This may help.

It won't for the suspend case; the bios just forgets to re-enable the 
PCI bridge to and the eepro100 card itself during resume. I have a patch 
to work around this and will clean it up enough for it to be acceptable 
for the mainstream kernel.

Greetings,
   Arjan van de Ven

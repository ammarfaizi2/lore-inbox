Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274991AbRJFIiZ>; Sat, 6 Oct 2001 04:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275096AbRJFIiQ>; Sat, 6 Oct 2001 04:38:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39052 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274991AbRJFIiC>;
	Sat, 6 Oct 2001 04:38:02 -0400
Date: Sat, 06 Oct 2001 01:38:19 -0700 (PDT)
Message-Id: <20011006.013819.17864926.davem@redhat.com>
To: paulus@samba.org
Cc: jes@sunsite.dk, James.Bottomley@HansenPartnership.com,
        linuxopinion@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15294.47999.501719.858693@cargo.ozlabs.ibm.com>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
	<d3n136tc48.fsf@lxplus014.cern.ch>
	<15294.47999.501719.858693@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Sat, 6 Oct 2001 18:06:23 +1000 (EST)
   
   The argument for supplying this functionality in the PCI DMA code
   would be that if it was done there it could be done once, and in a
   sophisticated and efficient (and SMP-safe :) fashion, rather than
   ad-hoc in each driver.

The argument against it is that if you provide such an easy way out,
people will just blindly transform bus_to_virt/virt_to_bus without
considering more straightforward methods when they exist.

I can not even count on one hand how many people I've helped
converting, who wanted a bus_to_virt() and when I showed them
how to do it with information the device provided already they
said "oh wow, I never would have thought of that".  That process
won't happen as often with the suggested feature.

I am adamently against generic infrastructure to do this.  Yes, it's
social engineering, tough cookies... it's social engineering that I
know is working :-)

Franks a lot,
David S. Miller
davem@redhat.com

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316384AbSEOOqU>; Wed, 15 May 2002 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316385AbSEOOqT>; Wed, 15 May 2002 10:46:19 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14949 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316384AbSEOOqS>; Wed, 15 May 2002 10:46:18 -0400
Date: Wed, 15 May 2002 18:48:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2
Message-ID: <20020515164802.GG25593@dualathlon.random>
In-Reply-To: <20020515130328.GA19698@spylog.ru> <200205151435.g4FEZo990223@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 08:35:50AM -0600, Justin T. Gibbs wrote:
> >Hello.
> >
> >Hardware motherboard: Intel "Lancewood" L440GX, SCSI integrated, last BIOS/BMC
> >
> >1. 2.4.19pre1aa1 :  : 1CPU/HIGHMEM/3.5Gb
> 
> The key bit in the dump is this:
> 
> >scsi0:0:0:0: Attempting to queue an ABORT message
> >...
> >scsi0:0:4:0: Command already completed
> 
> Interrupts are not getting routed correctly for your motherboard
> in the 2.4.19pre release you are running.  I'm not sure what has
> changed there, but the aic7xxx driver is noticing, when told to
> abort a command, that it has already completed, but the interrupt
> for that completion was never received.  You may see different
> results if you play with the APIC I/O option.

This is going to be a problem with mainline, if you could do a binary
search across the 2.4.19pre patches (from pre2 to pre8) that would limit
the bug to a certain diff. thanks,

Andrea

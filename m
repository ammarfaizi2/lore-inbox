Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291738AbSBXWsm>; Sun, 24 Feb 2002 17:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291750AbSBXWsY>; Sun, 24 Feb 2002 17:48:24 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22277 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291729AbSBXWsC>; Sun, 24 Feb 2002 17:48:02 -0500
Date: Sun, 24 Feb 2002 23:48:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Paul Mackerras <paulus@samba.org>, Vojtech Pavlik <vojtech@suse.cz>,
        Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224234800.A2412@ucw.cz>
In-Reply-To: <15481.26697.420856.1109@argo.ozlabs.ibm.com> <Pine.LNX.4.10.10202241418420.8567-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202241418420.8567-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Sun, Feb 24, 2002 at 02:27:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 02:27:51PM -0800, Andre Hedrick wrote:
> 
> Obviously this will be a sticking point on the baseclock assumed for each
> host; however, the excitement of the commentary tends to validate the
> concerns express, but poor word choice.
> 
> Given the baseclock is used to setup PIO, and that is the method to issue
> and execute the command block, and all other transfers which are not DMA,
> it stands to reason, if this becomes messed up so will the transfers.
> 
> So my comments in concerns are valid given each host is different and
> those capable of determining there internal baseclock which may vary from
> the actual PCI slot baseclock, FSB, etc ... will be okay.  The rest of
> those which depend on user input of a default safe value which has been
> defined in the past and verified by history must remain.

And so they stay, if you read the patch. It doesn't change any
functionality, really, just the implementation.

> In the past we carried a global since driverfs was not present.

I don't think driverfs will change this much.

> As a point of reference for removal of the pci read/write space to the
> host, I strongly suggest that be left alone. 

Why? Please name at least one good reason.

> As for the removal of the
> settings file, may of the distributions use this as a means to issue
> script calls to enable and disable features w/o the use of an additional
> application like "hdparm".

I don't remember this being removed, but my memory may be wrong here.

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313742AbSDIGCn>; Tue, 9 Apr 2002 02:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313749AbSDIGCm>; Tue, 9 Apr 2002 02:02:42 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62217
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313742AbSDIGCl>; Tue, 9 Apr 2002 02:02:41 -0400
Date: Mon, 8 Apr 2002 23:01:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Thomas Zimmerman <thomas@zimres.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reworked CONFIG_IDE_TASKFILE_IO help text
In-Reply-To: <20020409024232.GA23839@darklands.zimres.net>
Message-ID: <Pine.LNX.4.10.10204082257440.23456-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Thomas Zimmerman wrote:

> On 04-Apr 09:50, Adrian Bunk wrote:
> > Hi Marcelo,
> > 
> > Configure.help contains the help text below that sounds more like a
> > comment to a patch than a helpful help message for a user of a stable
> > kernel:
> > 
> > +CONFIG_IDE_TASKFILE_IO
> > +  This is the "Jewel" of the patch.  It will go away and become the new
> > +  driver core.  Since all the chipsets/host side hardware deal w/ their
> > +  exceptions in "their local code" currently, adoption of a
> > +  standardized data-transport is the only logical solution.
> > +  Additionally we packetize the requests and gain rapid performance and
> > +  a reduction in system latency.  Additionally by using a memory struct
> > +  for the commands we can redirect to a MMIO host hardware in the next
> > +  generation of controllers, specifically second generation Ultra133
> > +  and Serial ATA.
> > +
> > +  Since this is a major transition, it was deemed necessary to make the
> > +  driver paths buildable in separtate models.  Therefore if using this
> > +  option fails for your arch then we need to address the needs for that
> > +  arch.
> > +
> > +  If you want to test this functionality, say Y here.
> > 
> > Could anyone provide a more useful help text?
> 
> Maybe this is better? 
> 
> CONFIG_IDE_TASKFILE_IO
>   This option enables a new standardized data-transport driver. It replaces
>   code currently in each chipset/host driver. This should help reduce
>   bugs and allow better data protection. This new code also packetizes
>   requests to enable rapid performance and reduce system latency. It also uses
>   structures so MMIO hardware can be used in second generation Ultra133 and
>   Serial ATA chipsets.
> 
>   Since this a a major reworking of current code, this will live along side
>   current drivers for now. If this doesn't work on your arch yell. 
> 
>   If you want to test this new driver (and have backups), say Y here. 

Actually, truth be known ... when I finish the transport layer you will
have a clean error recovery path in the driver.  More details soon, but do
not enable until you have ide-taskfile v0.31 or higher.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


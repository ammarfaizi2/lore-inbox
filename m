Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSDRURS>; Thu, 18 Apr 2002 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314449AbSDRURR>; Thu, 18 Apr 2002 16:17:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44296
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314448AbSDRURQ>; Thu, 18 Apr 2002 16:17:16 -0400
Date: Thu, 18 Apr 2002 13:16:23 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
In-Reply-To: <20020418195345.GA1309@codepoet.org>
Message-ID: <Pine.LNX.4.10.10204181307570.17538-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well the proper solution is for me to finish the "ide-flash" subdriver.
As CFA devices have special error transformations and decodes, as will any
SDA device.

Proper error path in the driver ... hmmm, I have a discription and batted
it around and more people understand the problem now.  The issue becomes
in full disclosure and not producing a mass panic.  I would like to have a
solution complete before "wolf" and nothing to kill the beast in sight.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 18 Apr 2002, Erik Andersen wrote:

> On Thu Apr 18, 2002 at 12:34:29PM -0700, Andre Hedrick wrote:
> > 
> > Thanks for the positive feedback!
> 
> FYI, I have tried it as well (ide-2.4.19-p6.all.convert.3a.patch
> on 2.4.19-p7 plus your recommended #if 0 change) and it has been
> working nicely for me as well on a number of machines.  This
> certainly seems to be a nice improvement.
> 
> > About to add and test HPT372 final and then complete the MMIO operations.
> > Next will be to make the driver do the error recovery path that block does
> 
> Can you go into a little detail on your plans for error handling?
> 
> I think the currently error handling for the ide-subsystem,
> especially in the presence of sequences of bad sectors, is not
> especially robust (and is quite slow)...  In one case I tested
> yesterday (with 2.4.19-p7 plus your patch) using a 340 MB
> microdrive with a big chunk of bad sectors on it (the device
> admittedly is in pretty sorry shape but makes an excellent
> ide-subsystem tester ;-), the kernel wedged solid while trying to
> read from it...
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


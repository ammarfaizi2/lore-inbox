Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314072AbSDZPsl>; Fri, 26 Apr 2002 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSDZPsk>; Fri, 26 Apr 2002 11:48:40 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59382
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314072AbSDZPsk>; Fri, 26 Apr 2002 11:48:40 -0400
Date: Fri, 26 Apr 2002 08:48:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Stephen Samuel <samuel@bcgreen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020426154833.GP574@matchmail.com>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Stephen Samuel <samuel@bcgreen.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426040457.GO574@matchmail.com> <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 12:35:55AM -0700, Andre Hedrick wrote:
> 
> Basically it is a global design flaw from the beginning, and since I have
> only 2.4 to address it is a real nasty!  Short version, each subdriver
> personally does not do unique error handling.  Thus a the simple good/bad
> approach to a darwin world has come to bite hard now.  There is a failure
> to address error/sense decoding based on the operations requested to
> perform.  Second the mainloop is ATA/IDE centered for all events and this
> is in proccess to be fixed for 2.4 soon.  Third requires all ATAPI to
> decode wrt to primary opcode executed and sense of the preferred event
> tables and not the generic catch all.
>
> It is a blood mess, and difficult to describe over email :-/ (for me).
>

Ok, so there is hope for a fix.  Andre, when you have the patches available,
I'm sure meny people from this thread would be willing to help test, just
announce.

Is there a place where you keep your latest patches with a little
documentation on the purpose of the changes?

> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> PS Mike, "Mr. Hedrick" was my genetic donor, "Andre" is what I answer too.
> 

??  I think you're thinking of someone else.  Read below, I addressed you as
"Andre", and IIRC always have.  I understand personally the "genetic donor"
problem though. 

Mike

> > Also, can someone say for sure (Andre) that this is a hardware limitation,
> > not a Linux IDE locking problem, and with no possibility of a software
> > work-around? 
> > 
> > Thanks,
> > 
> > Mike

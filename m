Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293577AbSBZLgS>; Tue, 26 Feb 2002 06:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293578AbSBZLgJ>; Tue, 26 Feb 2002 06:36:09 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:61191
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293577AbSBZLfy>; Tue, 26 Feb 2002 06:35:54 -0500
Date: Tue, 26 Feb 2002 03:22:54 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-ac1
In-Reply-To: <20020226102748.GA1402@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.10.10202260316480.14807-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use caution but I should have removed the generic ablity to enable
taskfile IO operations core as there is an atomic bug discovered upon
error in multi-mode write.  As long as you do not call enable that option
all is cool.

This is the same bug in 2.5.4/2.5.5.

However the case of excution in the development environment suffers for an
policy imposed on the driver cores.  This will be explained once I have at
least stablized that transport.

I made one key mistake and that is keep a comman method of entry out the
main loop, since applying an extract from the diagnostics API, but even
there I made and error but it is not fatal under those conditions.

Thus I have pulled the patches for now for 2.4.X, but those do not have
the ablity to enable other transport layer core, so if this was the update
applied all is COOL!

Cheers,

On Tue, 26 Feb 2002, Matthias Andree wrote:

> On Mon, 25 Feb 2002, Mike Fedyk wrote:
> 
> > On Tue, Feb 26, 2002 at 01:58:56AM +0100, Matthias Andree wrote:
> > > What's the state on ATA drives beyond 128 GB (GB == 2^30) or the IDE
> > > patch by Andre Hedrick? Do you have plans to merge that stuff, now that
> > > the IDE patch advocacy has calmed down again?
> > 
> > It's already in there...
> > 
> > Linux 2.4.18pre3-ac2                                
> >                                 
> > o       Re-merge the IDE patches               (Andre Hedrick and co)
> 
> Missed that. Shame on me. Thanks.
> 
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


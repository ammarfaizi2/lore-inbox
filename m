Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275956AbSIVA4E>; Sat, 21 Sep 2002 20:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbSIVA4E>; Sat, 21 Sep 2002 20:56:04 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46857
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S275956AbSIVA4D>; Sat, 21 Sep 2002 20:56:03 -0400
Date: Sat, 21 Sep 2002 17:57:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Greg KH <greg@kroah.com>
cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org,
       hardeneddrivers-discuss@lists.sourceforge.net
Subject: Re: my review of the Device Driver Hardening Design Spec
In-Reply-To: <20020921224235.GA28936@kroah.com>
Message-ID: <Pine.LNX.4.10.10209211754000.25090-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



#ifndef __MYDRVR_H__
#define __MYDRVR_H__

#define MYDRVR_IOCTL_MAGIC 'm'

#define MYDRVR_IOCTL_RCV    _IO(MYDRVR_IOCTL_MAGIC, 0)

typedef struct _MYDRVR_CONTEXT {

   unsigned long cRCV;  /* number of RCV ioctls made */
   unsigned long cDeviceOpen; /* device open count */

} MYDRVR_CONTEXT, *PMYDRVR_CONTEXT;

#define ZEROMEMORY(pAddr, cbSize)               \
{                                               \
    int i;                                      \
    char *d = (char *)(pAddr);                  \
    for ( i = 0; i < (cbSize); i++, *d++ = 0 ); \
}

#endif /* __MYDRVR_H__ */

SHEESH, COULD THEY LEARN THERE IS MORE TO LIFE THAN ALL CAPS??

Sweet, that is "stick ugly"!

stick ugly : beating with a stick and it can not made any uglier than it
		is presently.

Andre Hedrick
LAD Storage Consulting Group

On Sat, 21 Sep 2002, Greg KH wrote:

> On Sat, Sep 21, 2002 at 11:52:19PM +0200, Francois Romieu wrote:
> > [Cc list trimmed]
> > 
> > Greg KH <greg@kroah.com> :
> > [...]
> > > Oh, there's lots of code:
> > > 	A "hardened" binary kernel driver:
> > > 		http://unc.dl.sourceforge.net/sourceforge/hardeneddrivers/sampledriver-0.1-1.i386.rpm
> > > 	(um people, why a binary?  Where's the source for this?)
> > 
> > In the cvs. See:
> > http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/hardeneddrivers/sample_driver/src/
> 
> Thanks for pointing this out, I missed it.
> 
> Hm, if this is the code that the CG group is proposing for reliable
> drivers, we are all in trouble.  See:
> 	http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/hardeneddrivers/sample_driver/src/sampledriver.h?rev=1.1.1.1
> 
> as a very small example of what not to do :)
> 
> I'd be glad to provide concrete criticism of the other files in this
> directory, if I thought people would actually change their programming
> style to follow what their own spec says to do...
> 
> {sigh}
> 
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/hardeneddrivers/sample_driver/src/sampledriver_init.c?rev=1.1.1.1
> contains so many examples of bad style, and real bugs...
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



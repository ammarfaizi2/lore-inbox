Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSBDPYS>; Mon, 4 Feb 2002 10:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSBDPYJ>; Mon, 4 Feb 2002 10:24:09 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:15232 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289017AbSBDPX5>;
	Mon, 4 Feb 2002 10:23:57 -0500
Date: Mon, 4 Feb 2002 10:23:56 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: john slee <indigoid@higherplane.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <dank@kegel.org>
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <20020204124344.GA4757@higherplane.net>
Message-ID: <Pine.LNX.4.30.0202041017220.2423-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, john slee wrote:

> [ added dan to cc list ]
>
> On Sun, Feb 03, 2002 at 09:07:24PM -0800, H. Peter Anvin wrote:
> > > If not what do you guys think about extensions to the cdrom drivers to
> > > handle these types of things?
> > >
> >
> > Rather than a signal, it should be a file descriptor of some sort, so
> > one can select() etc on it.  Personally I can't imagine polling would
> > take any appreciable amount of resources, though.
> >
> > A more important issue is probably to get notification when the eject
> > button is pushed and the device is locked, so that it can try to
> > umount and eject it, unless busy.
>
> not so long ago dan kegel suggested an interface to signals based on
> file descriptors, and perhaps even an alpha patch implementing such.
> this allowed you to select() on them.
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99356014431024&w=2
>
> of particular interest is this quote from dan's fantasy manpage:
>
> > HISTORY
> >      sigopen() first appeared in the 2.5.2 Linux kernel.
>
> a bit late, but an uncanny prediction.
> dan, are you nostradamus ? :-)
>

Hahah that's hilarious.  I really like the idea, by the way, of this
sigopen() feature.  An inverse of that owuld be to map existing file
descriptors to signals, that way an application doesn't have to explicitly
select() on them, but rather can install a very asynchronous fd reader for
whenever the data is available.  I am not sure how useful this would be,
but in the case of asynch. cdrom events it would be useful.  :)

Also, why did the author of this manpage seem to complain about
conflicting signals?  You can always find out what signals your process is
waiting for....

-Calin



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132702AbRDNBnt>; Fri, 13 Apr 2001 21:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132707AbRDNBnj>; Fri, 13 Apr 2001 21:43:39 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:777 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132702AbRDNBnW>; Fri, 13 Apr 2001 21:43:22 -0400
Date: Fri, 13 Apr 2001 19:35:57 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
Message-ID: <20010413193557.A15009@vger.timpanogas.org>
In-Reply-To: <20010413184740.A14659@vger.timpanogas.org> <Pine.GSO.4.21.0104132118060.24992-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0104132118060.24992-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Apr 13, 2001 at 09:25:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 09:25:10PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 13 Apr 2001, Jeff V. Merkey wrote:
> 
> > Not meaning to offend, but how could you know what everyone 
> > who uses Linux needs in every instance?  NT, NetWare, etc. all
> > expose these types of APIs for Backup and anti-virus software,
> > etc.  The APIs in question are the very calls user space apps
> > call through the syscall to indicate who is using a device. 
> 
> Backup and AV software is not in the kernel, so they would
> be unable to use the thing, exported or not. Please, don't
> bring the strawmen.

Some NT anti-virus stuff is in-kernel, and it's there to catch people 
writing viruses that act like device drivers.  One day, if and 
when a Linux virus shows it's ugly head disguised as a kernel module, you 
will be backpeddling on this statement, and wishing we had in 
kernel anti-virus support.  In W2K, folks have written some 
clever viruses that plug into their kernel as bogus device 
drivers.

> 
> Novell's model (aka. "we don't need no stinkin' userland, everything
> is NLM and security be damned") is better left to rot in hell with Novell.

Well, I am working with them again, and they have taken quite a 
beating at our hands (and I sure didn't do them any good putting out
the file system on Linux and free Migration tools).  Saying the word "Linux" 
around Novell definitely solicits a very worried and serious response.  

I am trying to be nice to them -- Linux is eroding their installed 
base at light speed at this point.  I'm sorry to say they show 
absolutely **NO** interest in doing things to promote Linux to 
their installed base in anyway that could benefit either them 
or Linux. 

> 
> > Sure, I can send blind I/O requests to a device and I guess 
> > someone running fdisk in user space can blow the device away from beneath 
> > me since I have no way of locking those partitions I exclusively
> > own and stopping this is these apis are removed and modules 
> > cannot call them.  
> 
> Use filp_open() - it's that simple.


Thanks.  This is what I needed to know.  I saw filp_open() in the 
EXPORTS file, but was uncertain if this would be an unchanging API.  
You have clarified this.    

I will convert my code to use this call instead.  Linus, if Al wants
the APIs removed from the export list, it sounds like filp_open()
will handle future issues relative to my requirements, so I have
no objection to them being removed.   

I'll let Al know if there are any problems with using them.

Al,  Thanks for the info.

:-)

Jeff


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSHRUZE>; Sun, 18 Aug 2002 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSHRUZE>; Sun, 18 Aug 2002 16:25:04 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:4058 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315988AbSHRUZD>; Sun, 18 Aug 2002 16:25:03 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10208181305450.23171-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208181305450.23171-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 16:29:03 -0400
Message-Id: <1029702544.3331.18.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They're both.  Cerberus reports MEMORY errors only when dma is enabled
for the promise card. doesn't matter for the via chipset.  These MEMORY
errors just precursor data corruption on the disks.  badblocks
segfaulted during tests on both drives when dma was enabled on the
promise controller. Before i got drive corruption on both drives but
that was when i had swap on the promise controller, since then I have
not experienced data corruption on the via drive.  It's still uncertain
as to if the data corruption is something at the transfer level to the
promise controller or a more general ide dma memory corruption because
when dma is enabled on the promise controller and the cerberos test is
run, all I get is what i explained in my original post and then the
kernel always panic's after a number of errors (both badblocks test
errors and MEMORY errors).  

again, none of these errors show up when dma is disabled on the promise
controller.  

so by MEMORY error, i mean what cerberus reports as "MEMORY" errors. 
cerberus doesn't seem to report hdd data corruption, rather for some
reason badblocks segfaults.  If you have a data accuracy test you like
to run that i should try I'll do that.  But the data corruption that
i've seen only occurs after a couple days of being up with dma enabled
on the promise card and I haven't had time to be up that long since
moving my swap from the promise controller.  



On Sun, 2002-08-18 at 16:07, Andre Hedrick wrote:
> 
> Ed,
> 
> MEMORY errors explian please.
> 
> If you mean data corruption please use those words, they are screaming red
> flags for attention.
> 
> On 18 Aug 2002, Ed Sweetman wrote:
> 
> > Ok, devfs was removed and I got the old way working again.   cerberus
> > reports MEMORY errors when dma is enabled on the promise controller less
> > than 30 seconds after the test has begun. Just like every other time
> > i've had dma enabled on the promise controller.  
> > 
> > So it's not preempt. It's not devfs.  So now we have to face the fact
> > that it's either a hardware conflict that linux cannot handle or a
> > device driver bug.  
> > 
> > Any other suggestions? 
> > 
> > Now that i'm down to vanilla 2.4.19 perhaps it's time for some real
> > tests? 
> >  
> > 
> > On Sun, 2002-08-18 at 05:16, Ed Sweetman wrote:
> > > On Sun, 2002-08-18 at 05:10, Alexander Viro wrote:
> > > > 
> > > > 
> > > > On 18 Aug 2002, Ed Sweetman wrote:
> > > > 
> > > > > (overview written in hindsight of writing email)  
> > > > > I ran all these tests on ide/host2/bus0/target0/lun0/part1 
> > > > 
> > > > Don't be silly - if you want to test anything, devfs is the last thing
> > > > you want on the system.
> > > > 
> > > > 
> > > 
> > > 
> > > OK, i can remove devfs, but I dont really see how that would make dma
> > > transfers (memory) become corrupted and pio mode transfers (memory) to
> > > not.  
> > > 
> > > I'm going to remove it, but i dont see how it's going to affect what's
> > > going on. 
> >  
> > 
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> 



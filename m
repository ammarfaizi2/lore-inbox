Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRB0VWS>; Tue, 27 Feb 2001 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbRB0VWJ>; Tue, 27 Feb 2001 16:22:09 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:1288 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S129339AbRB0VVy>;
	Tue, 27 Feb 2001 16:21:54 -0500
Message-ID: <3A9C1A3A.8BC1BCF2@kasey.umkc.edu>
Date: Tue, 27 Feb 2001 15:20:58 -0600
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Zack Brown <zbrown@tumblerings.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <Pine.LNX.3.96.1010227091255.780M-100000@renegade>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown wrote:
> 
> Just curious, are there any plans to put Mosix into the standard kernel,
> maybe in 2.5, so folks could just configure it and go? it seems that the
> number of people with more than one computer might make this a feature many
> would at least want to try, especially if it was available as an option by
> default. Is there anything in the Mosix folks' implementation that would
> prevent this?

I'm not a knowledgeable person, but I've been following Mosix/beowulf/? for
a few years and trying to keep up.

I've thought that it would be good to break up the different clustering
frills -- node identification, process migration, process hosting, distributed
memory, yadda yadda blah, into separate bite-sized portions.  

Centralization would be good for standardizing on what /proc/?/?/? you read to
find out what clusters you are in, and whatis your node number there.  There
is a lot of theorhetical work to be done.

Until then, I don't expect to see the Complete Mosix Patch Set available
from ftp.kernel.org in its current form, as a monolithic set that does many things,
including its Very Own Distributed File System Architecture.

If any of the work from Mosix will make it Into The Standard Kernel it will be
by backporting and standardization.


Is there a good list to discuss this on?  Is this the list?  Which pieces of
clustering-scheme patches would be good to have? 

I think a good place to start would be node numbering.

The standard node numbering would need to be flexible enough to have one machine
participating in multiple clusters at the same time.

/proc/cluster/....	this would be standard root point for clustering stuff

/proc/mosix would go away, become proc/cluster/mosix

and the same with whatever bproc puts into /proc; that stuff would move to
/proc/cluster/bproc


Or, the status quo will endure, with cluster hackers playing catch-up.




-- 
                      David Nicol 816.235.1187 dnicol@cstp.umkc.edu
             "Americans are a passive lot, content to let so-called
                              experts run our lives" -- Dr. Science


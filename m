Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSIFNOu>; Fri, 6 Sep 2002 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSIFNOu>; Fri, 6 Sep 2002 09:14:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13062 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316845AbSIFNOt>; Fri, 6 Sep 2002 09:14:49 -0400
Message-ID: <3D78AB8B.A8C6328A@aitel.hist.no>
Date: Fri, 06 Sep 2002 15:20:11 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux-kernel@vger.kernel.org
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
References: <200209060917.g869H5c08220@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:

> > Oh, you saw the light. (-: I can assure you that most file systems make
> 
> The question is if they do it in a way I can read. If I can read it, I
> can fix it. There was too much noise inside e2fs to see a point or points
> of intercept. So the intercept has to be higher, and ..
> 
> > direct_IO, I plan to keep all metadata caching in place, just stop caching
> > the actual file data. That should give maximum performance I think.
> 
> But not correct behaviour wrt metadata in a shared disk fs. And your
> calculation of "maximum performance" is off. Look, you seem to forget
> this:
> 
>    suppose that I make the FS twice as slow as before by meddling with
>    it to make it sharable
The big question is, of course: Can you do that?  Can you make a fs
shareable
the way you want it with only a 2-times slowdown?  That'd be interesting
to see.

> 
>    then I simply share it among 4 nodes to get a two times _speed up_
>    overall.
Cool if it works, but then the next question is if you can make it
scaleable like that.  Will it really be 4x as fast with 4 nodes?
Maybe.  But it won't scale like that with more and more nodes,
that you can be sure of.  Sometime you max out the disk,
or the network connections, or the processing capacity of the
node controlling the shared device.  After that it don't
get any faster with more nodes.

> 
> That's the basic idea. Details left to reader.
No thanks.  It is the details that is the hard part here.

> I.e. I don't care if it gets slower. We are talking thousands of nodes
> here. Only the detail of the topology is affected by the real numbers.

Try, but thousands of nodes sharing one or more devices isn't
easy to get right.  People struggle with clusters much smaller than
that.

Helge Hafting

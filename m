Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbQLHRPX>; Fri, 8 Dec 2000 12:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132377AbQLHRPN>; Fri, 8 Dec 2000 12:15:13 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:8466 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S132364AbQLHRPD>; Fri, 8 Dec 2000 12:15:03 -0500
Message-ID: <3A310FF3.97C02D1@home.com>
Date: Fri, 08 Dec 2000 10:44:35 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.21.0012080321180.13163-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> 
> On Thu, 7 Dec 2000, Jeff V. Merkey wrote:
> 
> > I think there may be a case when a process forks, that the MMU or some
> > other subsystem is either not setting the page bits correctly, or
> > mapping in a bad page.  It's a LEVEL I bug in 2.4 is this is the case,
> > BTW.  In core dumps (I've looked at 2 of them from SSH) it barfs right
> > after executing fork() or one of the exec functions and at some places
> > in the code where there's not any obvious coding bugs.  Looks like some
> > type of mapping problem.  I reported it three months ago, but it was
> > pretty much ignored.
> >
> > Linus needs to add this one to the pre-12 list -- looks like some type
> > of mapping bug.
> 
> Now that you mention it, every app that has bombed has been the type
> that forks a lot. MpegTV, gtv, and make spring to mind. All apps drive
> the CPU load up quite a lot, which was why I initially suspected
> overheating. I don't see it on my other 2.4 boxes though which is
> suspicious. But they don't get as much of a beating as this, which was
> up until last week my main workstation.
> 
> regards,
> 
> Dave.
> 

I've noticed the same problem, and it occasionally happens with XFree86
4.0.1, as well.  Hopefully we've established that this is not the
hardware issue which gcc people of so fond of pushing sig 11s on (even
in the face of overwhelming evidence to the contrary).  It would be good
to have this put on a current to-do list and looked into.

-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

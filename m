Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271989AbRI0IRn>; Thu, 27 Sep 2001 04:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272020AbRI0IRh>; Thu, 27 Sep 2001 04:17:37 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:17938 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271989AbRI0IRU>; Thu, 27 Sep 2001 04:17:20 -0400
Message-ID: <3BB2E081.DEF4B97B@idb.hist.no>
Date: Thu, 27 Sep 2001 10:17:05 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Jos=E9?= Luis Domingo =?iso-8859-1?Q?L=F3pez?= 
	<jdomingo@internautas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 much better than previous 2.4.x :-)
In-Reply-To: <1001377785.1430.7.camel@gromit.house> <Pine.LNX.4.33L.0109242234410.19147-100000@imladris.rielhome.conectiva> <20010925203515.A227@squish.home.loc> <20010926200833.A1859@dardhal.mired.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

José Luis Domingo López wrote:

> In my test, OOM seems to work well most of the time, but not always. When
> in works, it works fine, that is, it doesn't kill applications too early,
> and (in recent kernel), multithreaded applications (like mozilla and
> staroffice) and fully wiped from memory ("old" 2.4.x kernels didn't kill
> all the threads, just the selected process ID).
> 
> When OOM doesn't work, the disk starts spinning like crazy, responsiveness
> in null, mouse doesn't move, consoles don't update, unability to switch to
> text consoles, etc. Giving time to the machine to recover itself is not
> helpful: after more than 15 minutes the disk continue to spin and sound
> like they were to inmediately crash :)

Seems to me you aren't necessarily OOM, that's why the killer don't
kick in.  You simply have a working set larger than RAM, and is
trashing into a hopeless slowness.  This slowness may even postpone
further allocations so you need more time to go OOM.  

If you _want_ to get OOM killed quickly - allocate way too much memory
but keep the working set small.

Helge Hafting

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRKHQ0N>; Thu, 8 Nov 2001 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRKHQ0D>; Thu, 8 Nov 2001 11:26:03 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:9 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S274789AbRKHQZv>; Thu, 8 Nov 2001 11:25:51 -0500
Date: Thu, 8 Nov 2001 17:25:48 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: william fitzgerald <william.fitzgerald3@beer.com>
Cc: linux-kernel@vger.kernel.org, williamf@cs.may.ie
Subject: Re: printk kernel logging for router
Message-ID: <20011108172548.J25034@arthur.ubicom.tudelft.nl>
In-Reply-To: <073EAB4D8C9C4A14CBAAC7C9C97D8242@william.fitzgerald3.beer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <073EAB4D8C9C4A14CBAAC7C9C97D8242@william.fitzgerald3.beer.com>; from william.fitzgerald3@beer.com on Fri, Nov 09, 2001 at 03:41:17PM +2400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 03:41:17PM +2400, william fitzgerald wrote:
> hi all,
> linux newbie here.

You might be interested in the kernelnewbies.org website, mailinglist,
and IRC channel.

> i need to know some information in regard to
> logging with printk statements.
> 
> my plan is to monitor the performance of a linux
> router.i'm adding printk  statements to the
> kernel to every function that is called by
> forwarding packets and in that way find precisely
> where a packet or packets  get lost.
> 
>  this is still in progress.

Don't be surprised if all that printing will degrade the performance of
your router.

> when i finally get all my printk statements in, i
> want to be able to flood my router on my own mini
> network.(router running on a p133 using
> redhat7.1)
> 
> my understanding of printk is that each time it
> is encountered it is written to disk.so for a lot
> of packets there will be alot of writes,
> therefore slowing the system and producing false
> results.

Printk doesn't write to disk, syslogd does.

> so how to i buffer or record  the printk
> statements and print them to disk  after my
> packets have gone through the router?
> 
>  do i edit the printk.c file and change the 
> line:
> 
>                           static char buf[1024];
> 
> and increase the size of the array?
> or do i edit the klogd.c program and change
> something in there?

Change /etc/syslogd.conf. Put all kernel messages into a separate
logging file and put a '-' before the log file name so syslogd will not 
sync the file after each write. See man syslogd, klogd, syslog.conf


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

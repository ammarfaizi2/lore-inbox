Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313471AbSDLJa3>; Fri, 12 Apr 2002 05:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313479AbSDLJa2>; Fri, 12 Apr 2002 05:30:28 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:21439 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id <S313471AbSDLJa1>; Fri, 12 Apr 2002 05:30:27 -0400
Message-ID: <3CB6A92D.452B85E8@bull.net>
Date: Fri, 12 Apr 2002 11:30:21 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: hu, fr-FR, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <Pine.LNX.4.33.0204111358000.20722-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> user-space ones, fine.  you ex-mainframers have yet to demonstrate
> any sane argument for why printk is bad.  for instance, it would be
> utterly trivial to add high-res timestamps.  trivial to make klogd
> a little more efficient.  no reason you can't plug your own
> analysis code into it, rather than the normal syslog approach.
> logging pid/gid/etc is nonsense for many, even most printk's.

I am not saying that printk is bad.
I use it myself, too, for what it is for.
During the bring up, test, debug phase it is useful.

Can you make sure with printk-s that no error log is lost, can
you tell when a log has actually reached a permanent store device ?
Can you force the people to use the same printk format ?
( I am still not good at artificial intelligence and
I am too lazy to modify my analysis code every time when somebody
modifies a printk. :-) )
Can you pass lots of data through a printk ?
Can you make sure that printks are not intermixed ?
(You need to revise all the printk-s: one event - a single printk.
Otherwise the mutex does not protect what you print.)

I was glad to find this error log feature that meets our requirements.
It provides us services which reduce our development cost and provides
us functionality at "usual industrial level" (see e.g. POSIX).

Regards,

Zoltan Menyhart
P.S.: Please CC your answers to Zoltan.Menyhart@bull.net

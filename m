Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUKCTXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUKCTXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUKCTXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:23:12 -0500
Received: from web26104.mail.ukl.yahoo.com ([217.12.10.228]:5011 "HELO
	web26104.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261821AbUKCTV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:21:56 -0500
Message-ID: <20041103192155.86313.qmail@web26104.mail.ukl.yahoo.com>
Date: Wed, 3 Nov 2004 20:21:55 +0100 (CET)
From: Roland Kaeser <roli8200@yahoo.de>
Subject: Re: [uml-user] Harddisk Shutdown while UML Guest Shutdown
To: Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-user@lists.sourceforge.net
Cc: Roland Kaeser <roli8200@yahoo.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200411032000.34677.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Thank You for Your answer. But my host kernel is a 2.6.7 with the skas patch. The
guest is a 2.6.9. Just an another info: The behaviour does not depend on the hostfs
configuration. It also happens when I use a ubd device. 
And no, the HOST!! freezes after exit of the guest kernel. And i get a Kernel panic
from the HOST!! kernel, this in case the host (ide) harddisk drive spins down (but
not spins up anymore). My idea is that some routines to spin down the harddisk are
been routed outside the uml guest kernel or not been sucessfully removed for the uml
architecture. Is it possible that the /sbin/halt binary can have made something with
the hosts harddisk?

How can i get the kernel panic message from the host?

Roland

 --- Blaisorblade <blaisorblade_spam@yahoo.it> schrieb: 
> On Wednesday 03 November 2004 08:53, Roland Kaeser wrote:
> > Hello
> >
> > I starting the UML Kernel with the following command:
> >
> > /install/uml/kernel/vmlinux mem=128M devfs=nomount con=xterm
> > eth0=tuntap,,,1.1.1.1 eth1=tuntap,,,2.2.2.2 root=/dev/root
> > rootflags=/install/uml/instances/hostfc2install rootfstype=hostfs
> >
> > The system starts up successfully, and opens all the xterm for the
> > consoles. I can login and work with the guest system.
> > Then I shut down the guest system from inside the guest system using the
> > command init 0 or shutdown.
> 
> > The guest shuts down normally.
> > But in the moment when the uml kernel exits in the xterm where I started
> > it, I CAN HEAR the harddisk of the host goes down.
> 
> Ok, with this explaination, I can believe that this happens. Sorry for my 
> first answer, I first took the most likely idea, i.e. the hard disk spins 
> down because it's no more used, but the host kernel is still alive and 
> kicking, and the hard drive will spin up when needed. Anyway, this 
> description, w
> 
> You are using a vanilla host kernel (2.6.9), so you have no SKAS patch 
> running, i.e. this is a host kernel bug, actually, and it is pretty severe. 
> Attach your .config in next email.
> 
> Can you please report that (including the kernel panic message) to LKML, 
> CC:ing the -devel list? Also, could you try that with different host kernels? 
> Different setups? Are you running your UML as root or not? If you are running 
> it as root, then try running it with an unprivileged userid.
> 
> > After this, nothing happens more on the host, even the mouse freezes. I
> > cannot start an other program or even access the harddisk or login on a
> > other tty.
> 
> > It freezes the whole guest system. 
> You mean obiously the "host" system (i.e. the hardware one; "guest" refers to 
> the UML instance).
> > About a minute later I get a 
> > Kernel Panic from the host kernel
> Try to copy and send the text of the panic, (most of the numbers can be 
> omitted, even because they are often hard to decode; the list of function 
> calls is more important than anything else).
> -- 
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
>  


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

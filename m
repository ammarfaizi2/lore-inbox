Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLARwf>; Fri, 1 Dec 2000 12:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLARwZ>; Fri, 1 Dec 2000 12:52:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:55305 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129324AbQLARwL>; Fri, 1 Dec 2000 12:52:11 -0500
Date: Fri, 1 Dec 2000 11:17:33 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: root <root@trgras.timpanogas.org>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Oops in 2.2.18 with pppd dial in server
Message-ID: <20001201111733.A16573@vger.timpanogas.org>
In-Reply-To: <20001130185926.A884@trgras.timpanogas.org> <E141pa0-0000CE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E141pa0-0000CE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 01, 2000 at 12:46:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 12:46:18PM +0000, Alan Cox wrote:
> > I was able to reproduce this oops with a somewhat more reliable ksymoops (I was ready for this nasty bug this time).  Looks like the problem is in the sockets
> > code.
> 
> The traces so far all match one description , this one included. Its the
> 'something scribbled a while ago and I just walked the list and found it'
> 
> Is your ppp module getting loaded/unloaded a lot. Im wondering if we have

Humm.  The kernel ppp module is not getting unloaded.  I am using both the
pppd 2.3.11 and pppd-mppe 2.3.10 versions (pppd-mppe has CHAP-80 and MPPE
patched into the code).  The user space module does load and unload a lot 
due to all the testing we are doing.  

I took the CWorthy ncurses interface I wrote for the NWFS tools, and am 
using it to write a pppconfig utility that handles modem setup, inittab, 
mgetty, options.ttyX, etc. so setting up a dial-in server will be as 
easy with IPX and IP as it is in NT.  

I have also noticed that pppd is not "kicking" modprobe -v the way it 
probably should, and the ppp kernel modules have to be loaded and 
configured manually.

Jeff

> a module related race. That would explain why folks running large ppp dialin
> servers simply dont see any problems
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

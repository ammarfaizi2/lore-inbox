Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272059AbRIIQ3j>; Sun, 9 Sep 2001 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272062AbRIIQ3b>; Sun, 9 Sep 2001 12:29:31 -0400
Received: from mnh-1-15.mv.com ([207.22.10.47]:62470 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S272059AbRIIQ3W>;
	Sun, 9 Sep 2001 12:29:22 -0400
Message-Id: <200109091746.MAA02088@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Shiva Raman Pandey" <shiva@sasken.com>
cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Query about Tun/Tap Modules 
In-Reply-To: Your message of "Sun, 09 Sep 2001 20:58:56 +0530."
             <9ng1q4$or1$1@ncc-z.sasken.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Sep 2001 12:46:40 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shiva@sasken.com said:
> Q1 : Now I am not able to understand how to use this module for my
> above stated purpose.
>      If anybody has used this utility(Tun/tap) before , please let me
> know how to get these ethernet packet going towards IP layer and IP
> packets going towards ethernet driver. 

It's not clear how similar my use of TUN/TAP is to what you want, but UML uses
TUN/TAP as one mechanism to network a virtual machine to the host, and it
works quite well.

See tuntap_up() in 
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/user-mode-linux/tools/uml_net/uml_net.c?rev=1.10&content-type=text/vnd.viewcvs-markup
for setting up a TUN/TAP interface and 
tuntap_user_read() and tuntap_user_write() (which are both trivial)
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/user-mode-linux/linux/arch/um/drivers/tuntap_user.c?rev=1.2&content-type=text/vnd.viewcvs-markup
for getting packets in and out of the interface.

				Jeff


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263235AbTCYRvP>; Tue, 25 Mar 2003 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263236AbTCYRvP>; Tue, 25 Mar 2003 12:51:15 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:53638 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S263235AbTCYRvL>; Tue, 25 Mar 2003 12:51:11 -0500
Subject: 2.4.20 and 6to4 tunneling
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048615339.1052.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 25 Mar 2003 13:02:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found a problem, I am not sure if it is in my configuration or
not.  I have no dedicated ipv6 addresses, however, my internal network
and the router are using 6to4 tunneling and uses the appropriate 2002:
addresses.  I am doing this to learn about ipv6 and possibly to develop
some software using ipv6.

The problem is that a website I set up on a friend's box in Finland
(which has a 2001 ipv6 address and doesn't use ipv6) loads the text just
fine.  However, I never do get the images, and if I do a netstat on the
server (in Finland), the connection shows open, with a sendq of about
the image file sizes.

This sounds like the old mtu problems where path mtu discovery was
broken.  However, I am unable to find much information.  Is this a bug
in the kernel, in the setup, or just me being silly?

vichu-ip6.innernet.org is the website, remove the -ip6 to get the ipv4
site.  Yes, it is a silly little website of me playing around.  The
image that definitely shows the problem is right at the top of the page.

I can provide ifconfig output or any other details necessary.  I have
tried to do ethereal analysis of the connection.  I don't seem to see
anything but the opening syn/syn of the connection carrying the image. 
It just seems the other end is broken.  The server is running RedHat 8
all errata, kernel 2.4.18-24.8.0.  Mine is a largely RedHat Phoebe with
a few packages from the newer rawhide.

Sorry if this is off topic, but I don't seem to be finding any
references to such problems w/ Google, so I thought it might be a kernel
bug, but am not quite positive of that yet.

Trever
--
"In protocol design, perfection has been reached not when there is
nothing left to add, but when there is nothing left to take away." --
RFC1925: The Twelve Networking Truths


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSBVRng>; Fri, 22 Feb 2002 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292940AbSBVRn0>; Fri, 22 Feb 2002 12:43:26 -0500
Received: from varenorn.icemark.net ([212.40.16.200]:25749 "EHLO
	varenorn.internal.icemark.net") by vger.kernel.org with ESMTP
	id <S292938AbSBVRnP>; Fri, 22 Feb 2002 12:43:15 -0500
Date: Fri, 22 Feb 2002 18:40:57 +0100 (CET)
From: beh@icemark.net
X-X-Sender: beh@berenium.icemark.ch
To: linux-kernel@vger.kernel.org
Subject: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
Message-ID: <Pine.LNX.4.44.0202221834480.1126-100000@berenium.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to suspend my A30P, the screen goes black, and then about a
second later, I have this on the console (and syslog of course):

	Unable to handle kernel NULL pointer dereference at virtual address 000000b0
	 printing eip:
	f882a876
	*pde = 00000000
	Oops: 0000
	CPU:    0
	EIP:    0010:[<f882a876>]    Tainted: PF
	EFLAGS: 00010246
	eax: 00000000   ebx: f7ef8000   ecx: c2013400   edx: f7e9bc00
	esi: 00000000   edi: 00000000   ebp: 00000000   esp: f7ef9ed0
	ds: 0018   es: 0018   ss: 0018
	Process kapm-idled (pid: 3, stackpage=f7ef9000)
	Stack: f7ef8000 00000000 f7e9ba00 f8844073 00000000 f7a42000 c2013408 c2016ab4
	       c2016aa0 00000003 f8844153 f7e9bc00 00000000 c01f8f9c c2013400 00000003
	       c01f907e c2013400 00000003 c2016aa0 00000003 00000003 c0278160 c01f9167
	Call Trace: [<f8844073>] [<f8844153>] [<c01f8f9c>] [<c01f907e>] [<c01f9167>]
	   [<c01f91f6>] [<c01219b6>] [<c0121a69>] [<c0110fb0>] [<c0111207>] [<c0111321>]
	   [<c01113a3>] [<c0111d38>] [<c010546f>] [<c0105478>]

	Code: 8b 9c 38 b0 00 00 00 85 db 74 28 8b 43 54 85 c0 74 1a 8b 80


I can continue to work on the machine, but when I try to shut down
the machine, it hangs trying to unload kernel card services (or
maybe immediately AFTER unloading them -- just the last to lines
before the freeze are 'unloading kernel card services'...

Also, what used to work on an A21P, I can no longer get the machine
to hibernate...



Any ideas, what's causing this?  If more information is needed,
just let me know, what additional info I should provide...

In case you need it, I made my /usr/src/lin/ux/.config available at

	http://icemark.net/beh/dotconfig-2.4.17



Any help would be appreciated! :)


        Benedikt

  BEAUTY, n.  The power by which a woman charms a lover and terrifies a
    husband.
			(Ambrose Bierce, The Devil's Dictionary)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTIEJYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTIEJYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:24:09 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:44524 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262261AbTIEJYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:24:03 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 5 Sep 2003 11:24:00 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: marcelo@conectiva.com.br, mason@suse.com, green@namesys.com, akpm@osdl.org,
       andrea@suse.de, alan@lxorguk.ukuu.org.uk, tejun@aratech.co.kr,
       chris@memtest86.com
Subject: Re: 2.4.22-pre lockups (case closed)
Message-Id: <20030905112400.087e3fb6.skraw@ithnet.com>
In-Reply-To: <1060952100.5046.2.camel@tiny.suse.com>
References: <20030814084518.GA5454@namesys.com>
	<Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
	<20030814194226.2346dc14.skraw@ithnet.com>
	<1060913337.1493.29.camel@tiny.suse.com>
	<20030815122827.067bd429.skraw@ithnet.com>
	<1060952100.5046.2.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I would like to give you the last update on the story:

short: hardware problem

long:
The box had two different types of RAM (both registered ECC) in it. Two were 1
GByte, four were 256 MByte to a total of 3 GByte. I had to find out that the
box runs flawlessly when using only the GByte modules _or_ only the 256 MByte
modules, but not the mix. All modules are from same vendor. The problem in
mixed setup does not show up in UP mode (memtest works!). It does not even show
up straight away, it takes days, but it is always there.
In fact - even though having sunk weeks of work - I am pretty happy that it
turned out not to be a kernel problem.
For the other setups that showed SMP-specific weirdness TeJun may have found
interesting explanations. I updated them all to 2.4.22 and have not seen any
problem yet.
For me it was really interesting to see that reiserfs setups obviously have a
completely different memory footprint than ext3, and altogether there seems a
remarkable difference between later kernels and former. The problem showed up
very seldom on 2.4.21 and below but within 2 days with 2.4.22.
Thanks to all who lend me their ears on the topic and sorry for wasting the
time.

Regards,
Stephan

PS: Obviously there are seldom cases where SMP support in memtest _could_ make
a difference ;-)


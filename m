Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268104AbRGYU1Y>; Wed, 25 Jul 2001 16:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268063AbRGYU1P>; Wed, 25 Jul 2001 16:27:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:59039 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268047AbRGYU07>;
	Wed, 25 Jul 2001 16:26:59 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 25 Jul 2001 20:26:58 GMT
Message-Id: <200107252026.UAA21184@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, kuznet@ms2.inr.ac.ru
Subject: Re: ifconfig and SIOCSIFADDR
Cc: linux-kernel@vger.kernel.org, net-tools@lina.inka.de, philb@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	Hello!

And hello again!

	> Yes. It didn't in 2.0.

	Soooory, it did. This behavior is copied from there. :-)

You are mistaken. I already quoted you the source.
In case you do not believe in source reading I can demo as well.

2.4:
# ifconfig lo netmask 255.254.0.0 10.0.0.150
# ifconfig lo
lo        Link encap:Local Loopback  
          inet addr:10.0.0.150  Mask:255.0.0.0
[2.4.6, net-tools 1.60]


2.0:
# ifconfig lo netmask 255.254.0.0 10.0.0.150
# ifconfig lo
lo        Link encap:Local Loopback  
          inet addr:10.0.0.150  Bcast:127.255.255.255  Mask:255.254.0.0

[2.0.34, net-tools 1.33]


As you see, the behaviour where setting the address kills
the already set netmask is new.



	> Yes. I liked such logic thirty years ago. That is Unix.

	:-) Seems, thirty years ago there were not only Internet but Unix too.

Yes, rounded to a nice number. I suppose we started using Unix
26 or 27 years ago or so.

	BTW I did not hear about any kind of Unix, which forgets
	to set a valid mask on newly selected address.

Linux 2.0, when there already is a nonzero mask.
A zero mask is replaced by a default:

2.0:
# ifconfig lo netmask 0.0.0.0 10.0.0.150
# ifconfig lo
lo        Link encap:Local Loopback  
          inet addr:10.0.0.150  Bcast:127.255.255.255  Mask:255.0.0.0
...

Andries



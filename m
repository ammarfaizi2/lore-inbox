Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbTF1Tu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbTF1Tu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:50:58 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.161]:65517 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S265390AbTF1Tu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:50:56 -0400
Message-ID: <3EFDF4DA.80201@hipac.org>
Date: Sat, 28 Jun 2003 22:04:42 +0200
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pekka Savola <pekkas@netcore.fi>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <Pine.LNX.4.44.0306270900260.3068-100000@netcore.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka

You wrote:
> Looks interesting.  Is there experience about this in bridging firewall 
> scenarios? (With or without external patchset's like 
> http://ebtables.sourceforge.net/)

Sorry for this answer being so late but we wanted to check whether
nf-hipac works with the ebtables patch first in order to give you
a definite answer. We tried on a sparc64 which was a bad decision
because the ebtables patch does not work on sparc64 systems.
We are going to test the stuff tomorrow on an i386 and tell you
the results afterwards.

In principle, nf-hipac should work properly whith the bridge patch.
We expect it to work just like iptables apart from the fact that
you cannot match on bridge ports. The iptables' in/out interface
match in 2.4 works the way that it matches if either in/out dev
_or_ in/out physdev. The nf-hipac in/out interface match matches
solely on in/out dev.

> Further, you mention the performance reasons for this approach.  I would 
> be very interested to see some figures.

We have done some performance tests with an older release of nf-hipac.
The results are available on http://www.hipac.org/

Apart from that Roberto Nibali did some preliminary testing on nf-hipac.
You can find his posting to linux-kernel here: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=103358029605079&w=2

Since there are currently no performance tests available for the
new release we want to encourage people interested in firewall
performance evaluation to include nf-hipac in their tests.


Regards,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+


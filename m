Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287472AbRLaJOE>; Mon, 31 Dec 2001 04:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287473AbRLaJNy>; Mon, 31 Dec 2001 04:13:54 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:13066 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S287472AbRLaJNs>; Mon, 31 Dec 2001 04:13:48 -0500
Message-Id: <4.3.2.7.2.20011231090710.00ab7e30@192.168.124.1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 31 Dec 2001 09:12:44 +0000
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Roy Hills <linux-kernel-l@nta-monitor.com>,
        Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
        linux-kernel@vger.kernel.org
From: Roy Hills <linux-kernel-l@nta-monitor.com>
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <01122909300800.01870@manta>
In-Reply-To: <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
 <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
 <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:30 29/12/01 -0200, vda wrote:
>Maybe it's better to fix a20 problem? I never heard about Tecra a20 bug,
>can you point me to the info?
>--
>vda

My understanding is that the problem is something to do with the
Toshiba Tecra laptops not flushing the cache properly when activating
the A20 line.  This causes a problem for bzImage kernels because they
decompress into extended memory, whereas zImage kernels don't and
thus don't tickle the bug.

Unfortunately, I haven't seen a proper technical description of the problem
nor any workaround or patch.

Earlier versions of Debian Linux e.g. 2.1 (the distro that I use) used to 
supply
special "Tecra" kernels because of this problem.

Alan Cox said in a previous message in this thread:

ac>If your tecra is one with the problem early intel PCI chipsets the
ac>documentation on the workaround is on the intel.com site if you feel
ac>creative 8)

ac>Basically the A20 handling for hardware caches on some of these early chips
ac>was broken. There were real hardware fixes for new boards and a software
ac>workaround for old ones is described in the errata docs for the chip.

This sounds about right, but I've not been able to locate the info on Intel's
website.

Roy Hills
--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/


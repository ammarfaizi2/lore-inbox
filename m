Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUB0Nbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUB0Nbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:31:52 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:4281 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262866AbUB0Nbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:31:51 -0500
Date: Fri, 27 Feb 2004 21:31:43 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Subject: Re: Why no interrupt priorities?
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Mark Gross" <mgross@linux.co.intel.com>, arjanv@redhat.com,
       "Tim Bird" <tim.bird@am.sony.com>, root@chaos.analogic.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <1077859968.22213.163.camel@gaston> <opr30muhyf4evsfm@smtp.pacific.net.th> <20040227090548.A15644@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr306i5cm4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040227090548.A15644@flint.arm.linux.org.uk>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 09:05:48 +0000, Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Feb 27, 2004 at 02:26:31PM +0800, Michael Frank wrote:
>> Is this to imply that edge triggered shared interrupts are used anywhere?
>
> It is (or used to be) rather common with serial ports.  Remember that
> COM1 and COM3 were both defined to use IRQ4 and COM2 and COM4 to use
> IRQ3.
>
>> Never occured to me to use shared IRQ's edge triggered as this mode
>> _cannot_ work reliably for HW limitations.
>
> The serial driver takes great care with this - when we service such an
> interrupt, we keep going until we have scanned all the devices until
> such time that we can say "all devices are no longer signalling an
> interrupt".
>
> This is something it has always done - it's nothing new.
>

Sorry, i think the serial driver IRQ is level triggered :)

Regards
Michael


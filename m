Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCUHEy>; Thu, 21 Mar 2002 02:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSCUHEp>; Thu, 21 Mar 2002 02:04:45 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:54745 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292466AbSCUHE0>; Thu, 21 Mar 2002 02:04:26 -0500
Date: Thu, 21 Mar 2002 08:54:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <20020320202401.GA785@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0203210849320.32455-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, William Lee Irwin III wrote:

> There is/was at least one simulator that shoots the kernel (and
> everything else) dead in response to frobbing the PIC while the local
> APIC timer etc. are going, and I wouldn't be surprised if there were
> some real hardware that did so as well.

The problem was that the the simulator didn't support polling mode, which 
linux 2.4 seems to use for handling the timer interrupt. The simulator PIC 
implementation wasn't complete if it didn't support polling mode. You 
shouldn't see this on real hardware.

	Zwane



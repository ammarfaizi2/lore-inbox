Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272251AbRHWMoS>; Thu, 23 Aug 2001 08:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272250AbRHWMoI>; Thu, 23 Aug 2001 08:44:08 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61959 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S272249AbRHWMn5>;
	Thu, 23 Aug 2001 08:43:57 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15236.63384.489975.150804@cargo.ozlabs.ibm.com>
Date: Thu, 23 Aug 2001 22:31:20 +1000 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC
  add_timer_randomness()
In-Reply-To: <Pine.LNX.4.21.0108231137080.2015-100000@ltgp.iram.es>
In-Reply-To: <15236.23943.260421.31691@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.21.0108231137080.2015-100000@ltgp.iram.es>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert writes:

> Reading the PVR is probably faster in this case, since you avoid a
> potential cache miss.

Yep.

> As I said in an earlier message the __USE_RTC macro
> should be made dependent on whether the kernel supports 601 or not.

We don't have USE_RTC in 2.2.  The proposed patch was for 2.2.19.

> No, this is not what they are trying to capture. Furthermore the 7 LSB of
> the decrementer on a 601 are not random (but they don't seem to be 0
> always despite the documentation) so you would have to shift the result

Don't you mean that the 7 LSB of RTCL aren't random and are supposed
to be 0?  The decrementer should decrement by 1 at a rate of 7.8125MHz
and all the bits should be implemented.

Paul.

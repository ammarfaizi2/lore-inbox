Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbRCIHxz>; Fri, 9 Mar 2001 02:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRCIHxp>; Fri, 9 Mar 2001 02:53:45 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:33029 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130449AbRCIHxe>;
	Fri, 9 Mar 2001 02:53:34 -0500
Date: Fri, 9 Mar 2001 08:53:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Daniela Engert <dani@ngrt.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
Message-ID: <20010309085303.A690@suse.cz>
In-Reply-To: <20010308195107.A8509@suse.cz> <20010309072110.DB1C73E75@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010309072110.DB1C73E75@mail.medav.de>; from dani@ngrt.de on Fri, Mar 09, 2001 at 08:25:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 08:25:43AM +0100, Daniela Engert wrote:

> >They're about the same - only Alan didn't like the PCI speed measurement
> >code that's new in the 4.x series, so I added all the other changes to
> >the 3.20 driver, and 3.21 was born.
> 
> I do understand Alan's objections against this speed measurement code
> very well. I have similar code built into other (non-Linux) drivers,
> and according to the many user reports that I got the measurement
> results should be taken with a grain of salt. It is working perfectly
> in most cases, but it may fail from time to time. There is a hidden
> assumption in this type of measurement which the device that you run
> the test against has to fulfill. If it doesn't (and it is not required
> to do to be conforming to the ATA spec), the measurement results (PCI
> bus clock) are bogus (typically way too high).

Actually I don't think my method can ever result in a measurement higher
than real PCI clock, but can result in a lower one (if the device
deasserts IORDY even on a speed slower than PIO_0), which is also a
problem. Anyway, on fast machines the accuracy of the current algorithm
is +- .01 MHz.

Once tested a little more, the measurement will probably go in, however
with an option for the user to override it with a command line
parameter.

Btw, if it isn't a secret - what other drivers are those and what is the
exact method you used ... ?

-- 
Vojtech Pavlik
SuSE Labs

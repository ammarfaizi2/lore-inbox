Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSLOPAD>; Sun, 15 Dec 2002 10:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSLOPAD>; Sun, 15 Dec 2002 10:00:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64005 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261669AbSLOPAB>; Sun, 15 Dec 2002 10:00:01 -0500
Date: Sun, 15 Dec 2002 15:07:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: early_serial_setup is broken in the 2.5 series
Message-ID: <20021215150752.A6486@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Murphy <brian@murphy.dk>,
	linux-kernel@vger.kernel.org
References: <3DFC921C.1030302@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFC921C.1030302@murphy.dk>; from brian@murphy.dk on Sun, Dec 15, 2002 at 03:30:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 03:30:52PM +0100, Brian Murphy wrote:
> As far as I can see early_serial_setup should be capable of being
> used to dynamically setup a serial port at any time in the boot
> process - this is certainly the case in the 2.4 kernels.
> 
> However if it is used during architecture initialization, for example,
> then the serial8250_reg uart driver has not been registered and
> initialized even though it is used in the early_serial_setup call.
> 
> What was wrong with the 2.4 implimentation where the registered
> serial ports were saved until the serial driver was ready to use them?

Its broken at present.  Last I heard, Khalid is working on a fix (since
he has the hardware to be able to test it, its sensible that I wait
until he has a fix.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


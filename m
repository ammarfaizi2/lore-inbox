Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUI1VTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUI1VTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267977AbUI1VR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:17:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29199 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267971AbUI1VQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:16:14 -0400
Date: Tue, 28 Sep 2004 22:16:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: =?iso-8859-1?Q?Roland_Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver hangs
Message-ID: <20040928221600.D14747@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	=?iso-8859-1?Q?Roland_Ca=DFebohm?= <roland.cassebohm@VisionSystems.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <1096405831.2513.37.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096405831.2513.37.camel@deimos.microgate.com>; from paulkf@microgate.com on Tue, Sep 28, 2004 at 04:10:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 04:10:31PM -0500, Paul Fulghum wrote:
> On Tue, 2004-09-28 at 10:34, Roland Caßebohm wrote:
> > I have tried just to read all byte left in the FIFO of the 
> > UART in that case and throw them away.
> 
> In my opinion, this is the correct way to handle the problem.
> This is what I do in the SyncLink drivers.

Some 16x50 ports (most of the ones higher than 16550A) have auto flow
control, so if this is enabled you really don't want to drop bytes in
the FIFO on the floor.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

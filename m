Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbSK2KJV>; Fri, 29 Nov 2002 05:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbSK2KJV>; Fri, 29 Nov 2002 05:09:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266999AbSK2KJV>; Fri, 29 Nov 2002 05:09:21 -0500
Date: Fri, 29 Nov 2002 10:16:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] pci_siig* interdependence
Message-ID: <20021129101640.A32306@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0211280336580.14410-100000@montezuma.mastecende.com> <20021129085134.GA2257@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021129085134.GA2257@pazke.ipt>; from pazke@orbita1.ru on Fri, Nov 29, 2002 at 11:51:34AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 11:51:34AM +0300, Andrey Panin wrote:
> > This patch is to fix a compilation problem (functions are shared with
> > parport_serial) as well as fix a potential oops (parport_serial as module
> > would try and reference the freed memory)
> 
> The problem you are seeing caused by semiapplied patch moving SIIG combo
> cards support from 8250_pci.c to parport_serial.c
> Parport patch already applied, while serial one still isn't.

Why didn't whoever integrated the patch apply both halves.  Applying
one half without the other breaks things, and without proper co-ordination
between two people applying the exact same patch (which obviously didn't
happen) you can expect breakage.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


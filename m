Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317817AbSG2UPP>; Mon, 29 Jul 2002 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSG2UPP>; Mon, 29 Jul 2002 16:15:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56841 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317817AbSG2UPO>; Mon, 29 Jul 2002 16:15:14 -0400
Date: Mon, 29 Jul 2002 21:18:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Remco Treffkorn <remco@rvt.com>
Cc: Dan Malek <dan@embeddededge.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020729211829.F25451@flint.arm.linux.org.uk>
References: <20020729174341.GA12964@opus.bloom.county> <20020729181352.27999@192.168.4.1> <3D4592D3.50505@embeddededge.com> <200207291246.43134.remco@rvt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207291246.43134.remco@rvt.com>; from remco@rvt.com on Mon, Jul 29, 2002 at 12:46:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 12:46:42PM -0700, Remco Treffkorn wrote:
> On Monday 29 July 2002 12:09, Dan Malek wrote:
> > or a mix of both.  The problems to solve are drivers fighting over minor
> > device numbers and assumptions about the system console.
> >
> 
> Drivers need not fight about minor numbers. That can be simply handled:
> 
> int get_new_serial_minor()
> {
>     static int minor;
> 
>     return minor++;
> }
> 
> Any serial driver can call this when it initializes a new uart.
> Hot pluggable drivers have to hang on to their minors, and
> re-use.

It's a possible solution, if we get the ability for drivers to hang
on to their minors.  However, I get the feeling that this isn't going
to happen before 2.6.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


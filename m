Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWBFTmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWBFTmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBFTmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:42:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932322AbWBFTmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:42:40 -0500
Date: Mon, 6 Feb 2006 14:41:54 -0500
From: Dave Jones <davej@redhat.com>
To: Yuki Cuss <celtic@sairyx.org>
Cc: David Vrabel <dvrabel@arcom.com>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: SERIAL_8250_RUNTIME_UARTS must be <= SERIAL_8250_NR_UARTS
Message-ID: <20060206194153.GA30359@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Yuki Cuss <celtic@sairyx.org>, David Vrabel <dvrabel@arcom.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <43E72479.4020804@arcom.com> <43E7280B.6060607@sairyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E7280B.6060607@sairyx.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 09:42:19PM +1100, Yuki Cuss wrote:
 > David Vrabel wrote:
 > 
 > >If SERIAL_8250_RUNTIME_UARTS is > SERIAL_8250_NR_UARTS then more serial
 > >ports are registered than we've allocated memory for.  Prevent this by
 > >limiting SERIAL_8250_RUNTIME_UARTS in the serial Kconfig.
 > >
 > >Signed-off-by: David Vrabel <dvrabel@arcom.com>
 > > 
 > >
 > 
 > Is there any real use case for having *less* registered serial ports and 
 > having some spare?

Having the ability to build a kernel image which supports many serial ports,
whilst at the same same time when booted on the common-case systems with
two serial ports, not creating so many /dev/ttyS* nodes or sysfs objects
wasting ram that'll never be used or reclaimed.

		Dave

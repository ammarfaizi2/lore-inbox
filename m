Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTJWVQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTJWVQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:16:20 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:17843
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261817AbTJWVQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:16:18 -0400
Subject: Re: [RFC] must fix lists
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       piggin@cyberone.com.au,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Andi Kleen <ak@suse.de>, Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1066791032.25426.59.camel@cube>
References: <3F94C833.8040204@cyberone.com.au>
	 <1066791032.25426.59.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1066943495.6156.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Thu, 23 Oct 2003 22:11:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-10-22 at 03:50, Albert Cahalan wrote:
> The system in question would also lose time when
> under heavy load. Note that HZ is now 1000 HZ.
> If interrupts are kept off for too long or an
> SMI grabs the CPU...

With a lot of laptops this is a huge problem. Its one of the reasons Red
Hat went back to 100Hz in the RH 2.4 tree. With many laptops your clock
becomes junk at 1Khz. It will be interesting to see if the ACPI timers
help but that wont solve things for older laptops.

BTW another one for the list might be the SiS IRQ routing fixes from 2.4
if not merged otherwise newer sis and some older intel wont work
properly.



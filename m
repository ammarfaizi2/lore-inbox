Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUDSWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUDSWEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUDSWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:04:40 -0400
Received: from mail.ccur.com ([208.248.32.212]:34317 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261943AbUDSWEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:04:38 -0400
Date: Mon, 19 Apr 2004 18:04:37 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Willy Tarreau <w@w.ods.org>, cramerj@intel.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, csc@cadence.com
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040419220437.GA5817@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040416224422.GA19095@tsunami.ccur.com> <20040417072455.GD596@alpha.home.local> <20040419165425.GA3988@tsunami.ccur.com> <20040419193930.GA28340@alpha.home.local> <Pine.LNX.4.58.0404191615560.2252@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404191615560.2252@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 04:16:58PM -0400, Zwane Mwaikambo wrote:
> On Mon, 19 Apr 2004, Willy Tarreau wrote:
> 
> > Hi Joe,
> >
> > On Mon, Apr 19, 2004 at 12:54:25PM -0400, Joe Korty wrote:
> > >
> > > Uniprocessor 2.4.26 works fine.
> > > Uniprocessor 2.4.26 + local apic works fine.
> > > Uniprocessor 2.4.26 + local apic + io apic fails.
> >
> > interesting. Unfortunately, I didn't have time to try on the machine I told
> > you about last day. But right here, I have a dual athlon communicating with
> > an alpha, both with e1000 (544) in 2.4.26. Since there's a PCI bridge on your
> > quad, I wonder if the IOAPIC doesn't trigger an interrupt routing problem with
> > bridges. Are all the ports unusable or do some of them work reliably in APIC
> > mode ?
> 
> Joe could you also try it without ACPI if possible.


That was it.  Actually I had CONFIG_ACPI off (unknown reasons, inherited
.config), when I turned it on the board started to work.

Thanks everyone for all the input.

Joe

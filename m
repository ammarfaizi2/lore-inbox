Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVKWCZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVKWCZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVKWCZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:25:41 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:61341 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S932439AbVKWCZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:25:40 -0500
Date: Tue, 22 Nov 2005 18:25:33 -0800
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051123022533.GA30537@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20051122211947.GA29622@bougret.hpl.hp.com> <20051122165429.A30362@unix-os.sc.intel.com> <20051123020609.GA30491@bougret.hpl.hp.com> <20051122181242.A5214@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122181242.A5214@unix-os.sc.intel.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:12:43PM -0800, Rajesh Shah wrote:
> On Tue, Nov 22, 2005 at 06:06:09PM -0800, Jean Tourrilhes wrote:
> > 
> > 	This patch does not look right to me, but I must admit I have
> > no clue about what the code is doing. Can you confirm you want me to
> > try this ?
> > 
> Yes, please try this since this is known to fix at least a couple
> of other machines (see 
> https://bugzilla.novell.com/show_bug.cgi?id=116763)

	Ok, I tried it. It works. Kernel boot fine, Pcmcia card works,
X works.
	I double checked with /proc/cmdline that I did not have the
noacpi stuff.
	Works for me.

> The original acpi code ignored errors related to matching an
> acpi device to an acpi driver. I changed that behavior to flag
> an error, and this was wrong. An acpi device listed in the
> namespace should not be required to have a driver for it to
> be added to the acpi list.

	Well, your code is running well before any driver are
loaded... Even most drivers compiled-in are initialised later...

> thanks,
> Rajesh

	Jean


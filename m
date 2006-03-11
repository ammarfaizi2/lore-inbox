Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWCKHSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWCKHSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWCKHSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:18:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14001 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751702AbWCKHSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:18:36 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <200603101757.00060.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603101313.09754.dsp@llnl.gov>
	 <1142025821.2876.106.camel@laptopd505.fenrus.org>
	 <200603101757.00060.dsp@llnl.gov>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 08:18:31 +0100
Message-Id: <1142061512.3055.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 17:57 -0800, Dave Peterson wrote:
> On Friday 10 March 2006 13:23, Arjan van de Ven wrote:
> > hmm ok so I want a function that takes a device as parameter, and checks
> > the state of that device for errors. Internally that probably has to go
> > via a function pointer somewhere to a device specific check method.
> >
> > Or maybe a per test-type (pci parity / ECC / etc) check
> >
> > int pci_check_parity_errors(struct pci_dev *dev, int flags);
> >
> > something like that, or pci_check_and_clear_parity_errors()
> > (although that gets too long :)
> >
> > drivers can call that, say, after firmware init or something to validate
> > their device is sanely connected. Maybe pci_enable_device() could call
> > it too.
> >
> > This also needs a pci_suspend_parity_check() ... _resume_ ... so that
> > the driver can temporarily disable any checks, for example during device
> > reset/init. And then just before resume, it manually clears a check.
> 
> ok, perhaps things might look something like this?

<snip>

sounds like overdesign to me ;)




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVK1E7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVK1E7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 23:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVK1E7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 23:59:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:1719 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751232AbVK1E7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 23:59:30 -0500
Date: Mon, 28 Nov 2005 05:59:22 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, greg@kroah.com, kaos@sgi.com, ak@suse.de,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051128045922.GK20775@brahms.suse.de>
References: <20051127172725.GJ20775@brahms.suse.de> <24158.1133113176@ocs3.ocs.com.au> <20051127115640.3073f8e3.akpm@osdl.org> <20051127220329.GA17786@kroah.com> <20051128024301.GA8651@us.ibm.com> <20051127205745.78b565ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127205745.78b565ec.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 08:57:45PM -0800, Andrew Morton wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >
> > Any options I missed?
> 
> Stop using the notifier chains from NMI context - it's too hard.  Use a
> fixed-size array in the NMI code instead.

Or just don't unregister. That is what I did for the debug notifiers.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVAaSZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVAaSZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVAaSZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:25:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18573 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261299AbVAaSZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:25:10 -0500
Date: Mon, 31 Jan 2005 13:24:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bukie Mabayoje <bukiemab@gte.net>
Cc: sfeldma@pobox.com, David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       Michael Gernoth <simigern@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050131152431.GA14176@logos.cnet>
References: <20050130171849.GA3354@hardeman.nu> <1107143255.18167.428.camel@localhost.localdomain> <41FDB2D3.5CBD6F7D@gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41FDB2D3.5CBD6F7D@gte.net>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 08:23:47PM -0800, Bukie Mabayoje wrote:
> 
> Scott Feldman wrote:
> 
> > On Sun, 2005-01-30 at 09:18, David Härdeman wrote:
> > > I experience the same problems as reported by Michael Gernoth when
> > > sending a WOL-packet to computer with a e100 NIC which is already
> > > powered on.
> >
> > I didn't look at the 2.4 case, but for 2.6, it seems e100 was enabling
> > PME wakeup during probe.  PME shouldn't be enabled while the system is
> > up.  I suspect the assertion of PME while the system is up is what's
> > causing problems.  This patch moves PME wakeup enabling to either
> > suspend or shutdown.
> >
> > David, would you give this patch a try?  Make sure the system still
> > wakes from a magic packet if suspended or shut down, and doesn't cause
> > kacpid to go crazy if system is running.  If it helps for 2.6, perhaps
> > someone can look into 2.4 to see if there is something similar going on
> 
> This issue was reported on 2.4.

Can any of you guys test v2.6, please?


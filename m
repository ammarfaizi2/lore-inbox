Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVBVSDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVBVSDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVBVSDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:03:51 -0500
Received: from mailer1.psc.edu ([128.182.58.100]:1775 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S261207AbVBVSDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:03:32 -0500
Date: Tue, 22 Feb 2005 13:03:11 -0500 (EST)
From: John Heffner <jheffner@psc.edu>
To: Stephen Hemminger <shemminger@osdl.org>
cc: mlists@danielinux.net, "David S. Miller" <davem@davemloft.net>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlo Caini <ccaini@deis.unibo.it>,
       Rosario Firrincieli <rfirrincieli@arces.unibo.it>
Subject: Re: [PATCH] TCP-Hybla proposal
In-Reply-To: <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0502221247130.22393@dexter.psc.edu>
References: <200502221534.42948.mlists@danielinux.net>
 <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Stephen Hemminger wrote:

> On Tue, 22 Feb 2005 15:34:42 +0100
> Daniele Lacamera <mlists@danielinux.net> wrote:
>
> > One last note: IMHO we really need a better way to select congestion
> > avoidance scheme between those available, instead of switching each one
> > on and off. I.e., we can't say how vegas and westwood perform when
> > switched on together, can we?
>
> The protocol choices are mutually exclusive, if you walk through the code
> (or do experiments), you find that that only one gets used.  As part of the
> longer term plan, I would like to:
> 	- have one sysctl
> 	- choice by route and destination
> 	- union for fields in control block
>
>
> Is there interest in setting up a semi official "-tcp" tree to hold these?
> because it might not be of wide interest or stability to be ready for mainline
> kernel.


An idea I've been toying with for a while now is completely abstracting
congestion control.  Then you could have congestion control loadable
modules, which would avoid this mess of experimental algorithms inside the
main-line kernel.  If done right, they might be able to work seamlessly
with SCTP, too.  The tricky part is making sure the interface is complete
enough.

  -John

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVALSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVALSmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVALSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:42:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5338 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261209AbVALSmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:42:06 -0500
Subject: Re: node_online_map patch kills x86_64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111163504.D24171@build.pdx.osdl.net>
References: <20050111151656.A24171@build.pdx.osdl.net>
	 <20050112000726.GD14443@holomorphy.com>
	 <20050111163504.D24171@build.pdx.osdl.net>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1105555323.8266.2.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 12 Jan 2005 10:42:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 16:35, Chris Wright wrote:
> * William Lee Irwin III (wli@holomorphy.com) wrote:
> > On Tue, Jan 11, 2005 at 03:16:56PM -0800, Chris Wright wrote:
> > > Backing out the x86_64 specific bits of the numnodes -> node_online_map
> > > patch and the generic bits from wli, kills my machine at boot.
> > > It hits the early_idt_handler and dies straight away.  What would help
> > > to debug this thing?
> > 
> > The only part of this I'm responsible for is converting build_zonelists()
> > to pass its nodemask argument by reference to address a livelock. I feel
> > your pain and if not otherwise occupied I would help fix your problem
> > right away.
> 
> Thanks wli.  Seems Andi understands the issue despite my unintelligible
> bug report ;-)
> 
> thanks,
> -chris

So I assume you were trying to saying that backing out the patches makes
the machine boot, and leaving them in kills it, right?  And does Andi's
"[PATCH] x86_64: Optimize nodemask operations slightly" fix your
problem?  I'm assuming that's what the reference to "Andi understanding
the issue" meant?  Or is there still a problem booting x86_64 with the
numnodes -> node_online_map patches?

-Matt


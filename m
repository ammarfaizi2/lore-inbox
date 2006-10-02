Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWJBRXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWJBRXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWJBRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:23:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:2234 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965143AbWJBRXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:23:02 -0400
Date: Mon, 2 Oct 2006 12:23:00 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Message-ID: <20061002172300.GD4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com> <200609301240.03464.arnd@arndb.de> <20061002162749.GB4546@austin.ibm.com> <200610021850.41062.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610021850.41062.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 06:50:39PM +0200, Arnd Bergmann wrote:
> On Monday 02 October 2006 18:27, Linas Vepstas wrote:
> > > 
> > > I'm not sure if I have missed a patch in here, but I
> > > don't see anything reintroducing the 'netif_stop_queue'
> > > that is missing from the transmit path.
> > > 
> > > Do you have a extra patch for that?
> > 
> > Unfinished.  There are several ways in which the current 
> > spider-net driver doesn't do things the way Greg KH's, etal 
> > book on device drivers recommends. I was planning on combing 
> > through these this week.
> 
> Ok, that's good. However, removing the netif_stop_queue
> was an obvious oversight that happened during the cleanup
> last year.
> 
> Putting that one line back in should be a really safe fix for
> the problem of overly high system load we sometimes see.

Hmm. I have a patch from 5 weeks ago that seems to insert a bunch 
of these. I'm not sure why it hadn't been mailed before, I'll 
test and post as soon as I can.

--linas

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWJBQvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWJBQvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWJBQu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:50:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:40128 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932282AbWJBQu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:50:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Date: Mon, 2 Oct 2006 18:50:39 +0200
User-Agent: KMail/1.9.4
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20060929230552.GG6433@austin.ibm.com> <200609301240.03464.arnd@arndb.de> <20061002162749.GB4546@austin.ibm.com>
In-Reply-To: <20061002162749.GB4546@austin.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200610021850.41062.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 18:27, Linas Vepstas wrote:
> > 
> > I'm not sure if I have missed a patch in here, but I
> > don't see anything reintroducing the 'netif_stop_queue'
> > that is missing from the transmit path.
> > 
> > Do you have a extra patch for that?
> 
> Unfinished.  There are several ways in which the current 
> spider-net driver doesn't do things the way Greg KH's, etal 
> book on device drivers recommends. I was planning on combing 
> through these this week.

Ok, that's good. However, removing the netif_stop_queue
was an obvious oversight that happened during the cleanup
last year.

Putting that one line back in should be a really safe fix for
the problem of overly high system load we sometimes see.

	Arnd <><

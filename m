Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752196AbWJ0OXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbWJ0OXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbWJ0OXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:23:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14565 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752194AbWJ0OXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:23:47 -0400
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
From: Arjan van de Ven <arjan@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, proski@gnu.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cate@debian.org,
       gianluca@abinetworks.biz, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061026102630.ad191d21.randy.dunlap@oracle.com>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <20061026102630.ad191d21.randy.dunlap@oracle.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 27 Oct 2006 16:23:39 +0200
Message-Id: <1161959020.12281.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> ---
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> For ndiswrapper and driverloader, don't set the module->taints
> flags, just set the kernel global tainted flag.
> This should allow ndiswrapper to continue to use GPL symbols.
> Not tested.


can we put something in feature-removal that we'll undo this in say 6
months?

ndiswrapper is easy to fix to not use the internals of the queue_work
api, and just use schedule_work() instead. At that time the
functionality as a whole is still the right one.
(it's a separate question if ndiswrapper should be in this table;
driverloader should be, it's non-GPL at all, so that part of your patch
is broken)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


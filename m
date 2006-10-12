Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422837AbWJLIn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422837AbWJLIn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422843AbWJLIn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:43:58 -0400
Received: from ns.firmix.at ([62.141.48.66]:155 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1422837AbWJLIn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:43:57 -0400
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Pine.LNX.4.61.0610120956000.17740@yvahk01.tjqt.qr>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
	 <1160615547.20611.0.camel@localhost.localdomain>
	 <1160616905.6596.14.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0610120956000.17740@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 12 Oct 2006 10:35:49 +0200
Message-Id: <1160642150.2955.6.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.395 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 09:58 +0200, Jan Engelhardt wrote:
> >Interestingly, Linux is not the only OS that has been hit by this
> >problem:
> >
> >  http://blogs.sun.com/shepler/entry/port_623_or_the_mount
> 
> There is more to it. On a machine I had set up a second,
> experimental, apache on port 880. And it randomly failed to start on
> a boot because mountd had taken the port first.

FWIW I had the same experience several times with port 631 (aka "IPP")
taken by some RPC service and CUPS simply didn't worked.

> Man, this RPC stuff should go and use fixed ports.

Hmm, starting the portmapper as late as possible so that other services
get the chance to use their ports?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


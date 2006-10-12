Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbWJLQTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWJLQTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWJLQTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:19:55 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:27054 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422862AbWJLQTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:19:54 -0400
Date: Thu, 12 Oct 2006 17:49:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC traffic
In-Reply-To: <1160665277.6004.27.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0610121747230.28908@yvahk01.tjqt.qr>
References: <20061010165621.394703368@quad.kroah.org>  <20061010171429.GD6339@kroah.com>
  <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr> 
 <1160610353.7015.8.camel@lade.trondhjem.org>  <1160615547.20611.0.camel@localhost.localdomain>
  <1160616905.6596.14.camel@lade.trondhjem.org>  <Pine.LNX.4.61.0610120956000.17740@yvahk01.tjqt.qr>
 <1160665277.6004.27.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>man 8 mountd and check out the '-p' option. statd has a similar one.
>Even the in-kernel lockd daemon's can be set to listen to fixed ports.
>
>So there really shouldn't be any problems nailing down your RPC ports.

Thank you for the hint. However, poking /etc/init.d/nfsserver to use
the -p option is probably just as bad as adding "mountd 49500/tcp" to
/etc/services I am currently doing -- both get reverted on a distro
upgrade. Switching to CIFS will probably solve it all - one port
instead of three/four (and a fixed one), much more firewall- and
initscript-friendly.


	-`J'
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUINQXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUINQXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUINQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:18:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1470 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269536AbUINQOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:14:51 -0400
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
	Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Jakma <paul@clubi.ie>
Cc: Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf>
	 <1095008692.11736.11.camel@localhost.localdomain>
	 <20040912192331.GB8436@hout.vanvergehaald.nl>
	 <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
	 <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
	 <20040913201113.GA5453@vph.iki.fi>
	 <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095174633.16990.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 16:10:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 15:55, Paul Jakma wrote:
> Hmm, yes, I hadnt thought of the attack-mitigating aspects of 
> graceful restart. Though, without other measures, the session is 
> still is open to abuse (send RST every second).

Its more than that given port randomization, quite a lot more. Of course
its much easier to just send "must fragment, size 68" icmp replies and
guess them that way. This is spectacularly more effective and various
vendors highly invalid rst acking crap won't save you.



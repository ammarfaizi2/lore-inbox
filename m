Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVKQPhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVKQPhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVKQPhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:37:09 -0500
Received: from elektroni.phys.tut.fi ([130.230.131.11]:35815 "HELO
	elektroni.phys.tut.fi") by vger.kernel.org with SMTP
	id S1751340AbVKQPhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:37:00 -0500
Date: Thu, 17 Nov 2005 17:36:53 +0200
From: Petri Kaukasoina <kaukasoina502mkas9p@elektroni.phys.tut.fi>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hware clock left bad after a system failure
Message-ID: <20051117153653.GA15707@elektroni.phys.tut.fi>
Mail-Followup-To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	list linux-kernel <linux-kernel@vger.kernel.org>
References: <437B3C62.2090803@eyal.emu.id.au> <Pine.LNX.4.61.0511161037130.12055@chaos.analogic.com> <437BAA0E.2020602@eyal.emu.id.au> <Pine.LNX.4.61.0511170822590.7964@chaos.analogic.com> <437C8D67.2030806@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437C8D67.2030806@eyal.emu.id.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 01:02:15AM +1100, Eyal Lebedinsky wrote:
> On a hunch I did 'date' and the clock was 11h ahead (we actually
> are +11 now). So the problem is during the boot, not during the
> crash. I consider that the boot thinks that I am running a UTC
> hwclock and adjusts for this, when in fact I run a local time
> hwclock.

A wild guess follows. If /usr is on a separate partition from root,
/etc/localtime should be a file copied from /usr/share/zoneinfo/something
and not just a symlink...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269704AbUINTp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269704AbUINTp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbUINTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:43:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:39436 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269494AbUINTmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:42:07 -0400
Date: Tue, 14 Sep 2004 21:41:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Jakma <paul@clubi.ie>, Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040914194141.GF2780@alpha.home.local>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain> <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org> <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org> <20040913201113.GA5453@vph.iki.fi> <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org> <1095174633.16990.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095174633.16990.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Sep 14, 2004 at 04:10:36PM +0100, Alan Cox wrote:
> On Maw, 2004-09-14 at 15:55, Paul Jakma wrote:
> > Hmm, yes, I hadnt thought of the attack-mitigating aspects of 
> > graceful restart. Though, without other measures, the session is 
> > still is open to abuse (send RST every second).
> 
> Of course its much easier to just send "must fragment, size 68" icmp
> replies and guess them that way. This is spectacularly more effective
> and various vendors highly invalid rst acking crap won't save you.

Just wondering, I have not checked. Isn't the "must fragment" message
supposed to embed part of the packet it couldn't send in return ? If
this is the case (and if the victim processes it correctly), it would
need to guess a recent valid content. If it's not the case, I suspect
it would simply update the path mtu in the route cache, thus giving
spectacular effects :-)

Cheers,
Willy


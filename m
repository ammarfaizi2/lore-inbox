Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272678AbTG3CgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 22:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272680AbTG3CgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 22:36:06 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:51074 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S272678AbTG3CgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 22:36:04 -0400
Date: Wed, 30 Jul 2003 04:35:54 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730023554.GA29175@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com> <20030730012533.GA18663@mail.jlokier.co.uk> <20030730014004.GA22555@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730014004.GA22555@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 03:40:04AM +0200, Petr Vandrovec wrote:
> 
> I know that it is hack, but does not adding (wher ^[ is escape character)
> 
> append="blanking=^[[9;0]"
> 
> into /etc/lilo.conf solve this blanking problem? 

Unfortunately it does not work, printk() goes always through simple
layer which understands only CR, LF and BS. So left arrow is printed
instead of interpreting ESC.
							Petr

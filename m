Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTFJNZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFJNZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:25:21 -0400
Received: from mail.ithnet.com ([217.64.64.8]:46343 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262687AbTFJNZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:25:18 -0400
Date: Tue, 10 Jun 2003 15:38:15 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030610153815.57f7a563.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
	<20030609171011.7f940545.skraw@ithnet.com>
	<Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
	<20030610123015.4242716e.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 08:51:35 -0400 (EDT)
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> > Can you clarify? Do you mean options "nosmp noapic" or just "noapic" on SMP
> > kernel?
> 
> Kernel built with CONFIG_SMP and booted with 'noapic' kernel parameter

Ok. To speed up the tests I  call it "ok" if there are no verify errors within
70 GB and "fail" if there are one or more.
I have tried rc7+aic20030603 SMP with noapic and it is ok.

/proc/interrupts:

           CPU0       CPU1       
  0:    1061143          0          XT-PIC  timer
  1:       6582          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  5:       1229          0          XT-PIC  EMU10K1
  9:    9269694          0          XT-PIC  aic7xxx, aic7xxx, 3ware Storage Controller, fcpcipnp, eth0, eth1, eth2
 12:     129555          0          XT-PIC  PS/2 Mouse
 15:          4          0          XT-PIC  ide1
NMI:          0          0 
LOC:    1061054    1061028 
ERR:          1
MIS:          0


Reading around the whole interrupt stuff I came across a very simple idea which
I am going to test right now. See you in some hours ;-)

Regards,
Stephan


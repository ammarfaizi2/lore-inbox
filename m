Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUITWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUITWDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUITWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:03:38 -0400
Received: from mail.enyo.de ([212.9.189.167]:22789 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267374AbUITWDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:03:08 -0400
To: Paul Jakma <paul@clubi.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
References: <002301c498ee$1e81d4c0$0200a8c0@wolf>
	<1095008692.11736.11.camel@localhost.localdomain>
	<20040912192331.GB8436@hout.vanvergehaald.nl>
	<Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
	<Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
	<20040913201113.GA5453@vph.iki.fi>
	<Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
	<1095174633.16990.19.camel@localhost.localdomain>
	<Pine.LNX.4.61.0409141721270.23011@fogarty.jakma.org>
	<1095178175.17043.50.camel@localhost.localdomain>
	<Pine.LNX.4.61.0409141815460.23011@fogarty.jakma.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 21 Sep 2004 00:02:46 +0200
In-Reply-To: <Pine.LNX.4.61.0409141815460.23011@fogarty.jakma.org> (Paul
	Jakma's message of "Tue, 14 Sep 2004 18:17:53 +0100 (IST)")
Message-ID: <87zn3kmwe1.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Jakma:

>> TCP-MD5 has no effect on ICMP based attacks.,
>
> Hmm, good point. Which attacks, and what could be done about them? 
> (other than IPsec protect all traffic between peers).

You just filter ICMP packets, in the way RST packets are already
filtered (i.e. rate limit).

The only TCP desynchronization attack that has a chance of working
practice is the SYN-based one.  The rate limit for RST processing on
Cisco routers is far too low.

(Mixed Cisco/Quagga environments are a different matter, but rather
unusual and easily DoSed anyway, most of the time.)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUIUUFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUIUUFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUIUUFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:05:09 -0400
Received: from mail.enyo.de ([212.9.189.167]:13327 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S268033AbUIUUFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:05:02 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, paul@clubi.ie, alan@lxorguk.ukuu.org.uk,
       vph@iki.fi, toon@hout.vanvergehaald.nl, admin@wolfpaw.net,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
References: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au>
	<873c1bjwwj.fsf@deneb.enyo.de>
	<20040921125645.05fafd5a.davem@davemloft.net>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 21 Sep 2004 22:04:41 +0200
In-Reply-To: <20040921125645.05fafd5a.davem@davemloft.net> (David S. Miller's
	message of "Tue, 21 Sep 2004 12:56:45 -0700")
Message-ID: <871xgvie1y.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller:

> On Tue, 21 Sep 2004 20:32:12 +0200
> Florian Weimer <fw@deneb.enyo.de> wrote:
>
>> > But then you get PMTU problems...
>> 
>> PMTU discovery is not an issue because it's turned off anyway, at
>> least by default.
>
> It's on by default, for both TCP and UDP in the kernel,
> and has been so for a long time.

Linux is not the reference TCP/IP stack for routers. 8-)

> Why would it be off by default?

Probably because PMTUD is just a DRAFT STANDARD, and these router
folks are usually extremely conservative.  Switching the default is
dangerous because it's likely to break existing setups, as Herbert
noted.

> If you disable PMTU discovery, say goodbye to TCP performance.

Indeed.  On those platforms, the CPU impact is also significant, and
the overall increase in BGP convergence time is measurable.

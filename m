Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUAEJxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 04:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAEJxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 04:53:44 -0500
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:1969 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S263861AbUAEJxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 04:53:42 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Kenneth Johansson <ken@kenjo.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, szonyi calin <caszonyi@yahoo.com>,
       azarah@nosferatu.za.org, Con Kolivas <kernel@kolivas.org>,
       Soeren Sonnenburg <kernel@nn7.de>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <20040104234703.GY1882@matchmail.com>
References: <1073227359.6075.284.camel@nosferatu.lan>
	 <20040104225827.39142.qmail@web40613.mail.yahoo.com>
	 <20040104233312.GA649@alpha.home.local>
	 <20040104234703.GY1882@matchmail.com>
Content-Type: text/plain
Message-Id: <1073296227.8535.34.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 10:50:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > at a time. I have yet to understand why 'ls|cat' behaves
> > differently, but fortunately it works and it has already saved
> > me some useful time.
> 
> cat probably does some buffering for you, and sends the output to xterm in
> larger blocks.

you can try with "ls |dd bs=1"

I also see this problem but it is not constant. I noticed that "ps ax"
sometimes takes like 10 times longer than usual. But I can only get this
in a gnome-terminal not in xterm. The problem is that it should really
not be that big difference when the load of the system is the same. 

One thing to run is to start 4 xterm and run this little thing in
everyone.

while true ;do ls ;done

In a perfect world they should all appear to scroll at the same time.
This is not what is happening on my system. 



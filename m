Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVGIShX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVGIShX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGIShX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:37:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61606 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261680AbVGISgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:36:04 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: azarah@nosferatu.za.org, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <1120933916.3176.57.camel@laptopd505.fenrus.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan>  <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 14:36:02 -0400
Message-Id: <1120934163.6488.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 20:31 +0200, Arjan van de Ven wrote:
> why?

Because the minimum poll/select timeout is now 4ms rather than 1ms.  An
app that has a soft RT constraint somewhere in the middle that worked on
2.6.12 will break on 2.6.13.

> it's a config option. Some distros ship 100 already, others 1000, again
> others will do 250. What does it matter?
> (Although I still prefer 300 over 250 due to the 50/60 thing)
> 
> This is not a userspace visible thing really with few exceptions, and
> well people can select the one they want, right?

Then why not leave the default at 1000?

Lee


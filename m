Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVLPShE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVLPShE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVLPShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:37:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62923 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932374AbVLPShC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:37:02 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dnv0d3$4jl$1@sea.gmane.org>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <20051216140425.GY23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <dnv0d3$4jl$1@sea.gmane.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 19:36:59 +0100
Message-Id: <1134758219.2992.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 13:18 -0500, Giridhar Pemmasani wrote:
> Kyle Moffett wrote:
> 
> > I have yet to see any resistance to the 4Kb patch this time around
> > that was not "*whine* don't break my ndiswrapper plz".   There are
> 
> I haven't seen anyone demanding others not to have 4k stacks; only requests
> to leave 4k/8k stack option as it is. 

in hindsight making this a config option was a mistake. Why? Because
we're not making every single patch we add to the kernel a config
option, nor should it be. Config options for drivers or expensive debug
options are fine, debug options for random patches... aren't really. To
be fair the config option was intended to be really temporary, like 1
kernel release, until it was sure there were no kinks. Oh well, there's
too many people moaning now about ndiswrapper that I fear we'll never
get rid of it.

And no I do not think a kernel with 9000 config options is still useful;
not every single trivial thing should be a config option.



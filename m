Return-Path: <linux-kernel-owner+w=401wt.eu-S1751213AbXAOSUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbXAOSUX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXAOSUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:20:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60788 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbXAOSUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:20:22 -0500
Subject: Re: allocation failed: out of vmalloc space error treating and  
	VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: theSeinfeld@users.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
In-Reply-To: <45ABC1A2.90109@tmr.com>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org> <45ABC1A2.90109@tmr.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 15 Jan 2007 10:20:22 -0800
Message-Id: <1168885223.3122.304.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> I've used vmalloc in the past, and not had a problem, but it is a fair 
> question, how do you find out how much space is available? Other than a 
> binary vmalloc/release loop.

that's a really hard question since it's dynamic;
I suppose a good rule of thumb is "never expect more than 16Mb to work"
(when I said "64Mb" that was for the kernel as a whole, and there's
other users than just "you" :)

if you need that much you probably should redesign your algorithms to
not need vmalloc in the first place....


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


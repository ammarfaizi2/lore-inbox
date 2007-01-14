Return-Path: <linux-kernel-owner+w=401wt.eu-S1751673AbXANUsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXANUsB (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 15:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbXANUsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 15:48:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37547 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbXANUsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 15:48:00 -0500
Subject: Re: allocation failed: out of vmalloc space error treating and
	VIDEO1394 IOC LISTEN CHANNEL =?ISO-8859-1?Q?ioctl=A0failed?= problem
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Peter Antoniac <theSeinfeld@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.832df3763908c060@s5r6.in-berlin.de>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org>
	 <tkrat.832df3763908c060@s5r6.in-berlin.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 14 Jan 2007 12:48:00 -0800
Message-Id: <1168807680.3123.1137.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 21:31 +0100, Stefan Richter wrote:
> On 14 Jan, Arjan van de Ven wrote:
> > vmalloc space is limited; you really can't assume you can get any more
> > than 64Mb or so (and even then it's thight on some systems already);
> 
> I suppose "grep VmallocChunk /proc/meminfo" shows what is available?
> 
> > it really sounds like vmalloc space isn't the right solution for your
> > problem whatever it is (context is lost in the quoted mail)...
> > can you restate the problem to see if there's a better solution
> > possible?
> 
> Thanks. Below is Peter's message to linux1394-devel. The previous
> discussion went over libdc1394-devel which I don't receive. Obviously he
> wants a really large buffer for reception of an isochronous stream. I
> guess his reason is highly application specific...


but why does that even use vmalloc? You can just do a scatter gather
thing instead... and keep a list of pages that you're mapping into
userspace. vmalloc isn't really a requirement for that....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


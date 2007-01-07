Return-Path: <linux-kernel-owner+w=401wt.eu-S932586AbXAGP3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbXAGP3X (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbXAGP3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:29:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35573 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbXAGP3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:29:21 -0500
Subject: Re: useless asm/page.h exported to userspace for some architectures
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20070104174227.GA7593@infradead.org>
References: <8bd0f97a0701032300u1b1b45c7jebd3dbddfb1df27d@mail.gmail.com>
	 <20070104174227.GA7593@infradead.org>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 23:29:40 +0800
Message-Id: <1168183781.14763.25.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 17:42 +0000, Christoph Hellwig wrote:
> On Thu, Jan 04, 2007 at 02:00:20AM -0500, Mike Frysinger wrote:
> > most architectures (pretty much everyone but like x86/x86_64/s390)
> > export empty asm/page.h headers ... considering how useless these are,
> > why bother exporting them at all ?  clearly userspace is unable to
> > rely on it across architectures, so by making it available to the two
> > most common (x86/x86_64), applications crop up that build "fine" on
> > them but fail just about everywhere else
> 
> It should not be exported to userspace at all.  Care to submit a patch? 

I think we can kill off <asm/elf.h> too -- the only interesting parts
are in <asm/auxvec.h>, aren't they?

-- 
dwmw2


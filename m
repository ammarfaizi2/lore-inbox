Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVEFO1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVEFO1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVEFO1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:27:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38788 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261235AbVEFO1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:27:08 -0400
Subject: Re: Empty partition nodes not created (was device node issues with
	recent mm's and udev)
From: David Woodhouse <dwmw2@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Andries Brouwer <Andries.Brouwer@cwi.nl>,
       chrisw@osdl.org, aebr@win.tue.nl, "Randy.Dunlap" <rddunlap@osdl.org>,
       Greg KH <greg@kroah.com>, joecool1029@gmail.com,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1115388767.4989.2.camel@mulgrave>
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
	 <20050503031421.GA528@kroah.com>
	 <20050502202620.04467bbd.rddunlap@osdl.org>
	 <20050506080056.GD4604@pclin040.win.tue.nl>
	 <20050506081009.GX23013@shell0.pdx.osdl.net>
	 <20050506084259.GB25418@apps.cwi.nl>
	 <20050506020518.0b0afdc3.akpm@osdl.org>  <1115388767.4989.2.camel@mulgrave>
Content-Type: text/plain
Date: Fri, 06 May 2005 15:26:59 +0100
Message-Id: <1115389619.16187.222.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 09:12 -0500, James Bottomley wrote:
> Well, moving offtopic, but it is of relevance to people who use git.
> The answer is that the information exists (we can use the commit tree
> to reconstruct the file data) but that no-one has yet come up with a
> file history viewing tool.  I think David Woodhouse is the closest to
> producing one of these, David?

I posted a script which produces output along the lines of rev-tree's,
but which lists only commits relevant to a given file. However it lacked
correct information about the _branchpoint_ when branches were taken.
You could track the merges but not the full graph.

To do it properly would involve a modified version of rev-tree which
marks the 'interesting' commits and then prunes the uninteresting parts
before dumping what's left. I haven't got as far as _implementing_ that
yet.

-- 
dwmw2


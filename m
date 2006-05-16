Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWEPUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWEPUJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWEPUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:09:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750711AbWEPUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:09:23 -0400
Date: Tue, 16 May 2006 21:09:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark A Smith <mark1smi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: send(), sendmsg(), sendto() not thread-safe
Message-ID: <20060516200921.GB5060@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark A Smith <mark1smi@us.ibm.com>, linux-kernel@vger.kernel.org
References: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 02:39:06PM -0700, Mark A Smith wrote:
> 
> I discovered that in some cases, send(), sendmsg(), and sendto() are not
> thread-safe. Although the man page for these functions does not specify
> whether these functions are supposed to be thread-safe, my reading of the
> POSIX/SUSv3 specification tells me that they should be. I traced the
> problem to tcp_sendmsg(). I was very curious about this issue, so I wrote
> up a small page to describe in more detail my findings. You can find it at:
> http://www.almaden.ibm.com/cs/people/marksmith/sendmsg.html .

Please don't confuse thread safety with atomicy, thanks.


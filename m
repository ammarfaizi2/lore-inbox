Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbTGJPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269319AbTGJPU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:20:27 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:37608 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S266362AbTGJPU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:20:26 -0400
Date: Thu, 10 Jul 2003 08:34:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22 Give us today our daily wart...
Message-ID: <20030710153456.GB27605@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, trond.myklebust@fys.uio.no,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <16140.37833.903329.594693@charged.uio.no> <3F0C9D45.2020308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0C9D45.2020308@pobox.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 06:55:01PM -0400, Jeff Garzik wrote:
> Looks good to me...

I'm not sure that you care but this is completely incompatible with the
direct I/O extension that I did in IRIX's NFS, which was the first
direct I/O NFS implementation anywhere.  The IRIX approach was to use
a different code path, direct I/O went through a TCP socket which was
carefully managed so that page flipping would work.  If you want to 
know the details I can dig them up but unless you are going down the
page flipping route, this looks fine.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

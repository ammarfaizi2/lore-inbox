Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUFVMaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUFVMaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUFVMaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:30:00 -0400
Received: from [213.146.154.40] ([213.146.154.40]:53380 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263147AbUFVM3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:29:53 -0400
Date: Tue, 22 Jun 2004 13:29:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Dean Nelson <dcn@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add wait_event_interruptible_exclusive() macro
Message-ID: <20040622122948.GA2038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, Dean Nelson <dcn@sgi.com>,
	linux-kernel@vger.kernel.org
References: <40D30646.mailxA8X155I80@aqua.americas.sgi.com> <20040622120130.GA16246@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622120130.GA16246@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 05:01:30AM -0700, Chris Wedgwood wrote:
> Thsi reminds me...
> 
> I really loath all the preprocessor macros.  I know there are plenty
> of this already, but I don't see the advantage of macros over (static)
> inline functions which IMO look cleaner and give gcc some change to
> sanitize what it's looking at without actually having to have it used.
> 
> Is there a reason why we keep doing this?

In this case a macro is the only sensible way.  Check how the arguments
are used in wait_event_*


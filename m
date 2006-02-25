Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWBYXWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBYXWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 18:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBYXWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 18:22:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63715 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750721AbWBYXWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 18:22:09 -0500
Date: Sat, 25 Feb 2006 23:22:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060225232201.GK27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4400E34B.1000400@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 12:07:55AM +0100, Stefan Richter wrote:
> Chris Wright wrote:
> >* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> >>sd: fix memory corruption by sd_read_cache_type
> >
> >Looks like these still aren't upstream.  Can you please resend to -stable
> >once they've been picked up by Linus?
> 
> Yes, I will do so.

Speaking of sbp2 problems...  Why the _hell_ are we blacklisting on
firmware revision alone?  Especially with entries like "all firmware
with 2.<whatever> as version is broken"...

Case in point: Initio bridge, firmware revision 2.21.  Couldn't care
less about long INQUIRY, doesn't need skip_ms_page_8, *DOES* need
correctly detected cache type.

What kind of chipsets do affected devices really have?

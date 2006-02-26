Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWBZIWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWBZIWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 03:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWBZIWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 03:22:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60579 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751262AbWBZIWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 03:22:22 -0500
Date: Sun, 26 Feb 2006 08:22:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060226082206.GN27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <20060225232201.GK27946@ftp.linux.org.uk> <4401629C.8070803@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4401629C.8070803@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 09:11:08AM +0100, Stefan Richter wrote:
> Al Viro wrote:
> >Speaking of sbp2 problems...  Why the _hell_ are we blacklisting on
> >firmware revision alone?  Especially with entries like "all firmware
> >with 2.<whatever> as version is broken"...
> 
> The firmware_revision CSR key value has so far been a good method to 
> guesstimate the bridge chip. I don't know a better one.

Umm...  What about ->vendor_name_kv (plus firmware_revision, obviously)?
 
> I posted an improved blacklisting patch a few days ago. Among other 
> small cleanups, I removed skip_ms_page_8 from the Initio blacklist entry.
> http://marc.theaimsgroup.com/?l=linux1394-devel&m=114065678722190

FWIW, that puppy appears to live just fine without forcing 36byte
inquiry here...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWBZIMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWBZIMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 03:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWBZIMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 03:12:47 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:29384 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751259AbWBZIMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 03:12:46 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4401629C.8070803@s5r6.in-berlin.de>
Date: Sun, 26 Feb 2006 09:11:08 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <20060225232201.GK27946@ftp.linux.org.uk>
In-Reply-To: <20060225232201.GK27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.719) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Speaking of sbp2 problems...  Why the _hell_ are we blacklisting on
> firmware revision alone?  Especially with entries like "all firmware
> with 2.<whatever> as version is broken"...

The firmware_revision CSR key value has so far been a good method to 
guesstimate the bridge chip. I don't know a better one.

> Case in point: Initio bridge, firmware revision 2.21.  Couldn't care
> less about long INQUIRY, doesn't need skip_ms_page_8, *DOES* need
> correctly detected cache type.
...

I agree.

I posted an improved blacklisting patch a few days ago. Among other 
small cleanups, I removed skip_ms_page_8 from the Initio blacklist entry.
http://marc.theaimsgroup.com/?l=linux1394-devel&m=114065678722190
-- 
Stefan Richter
-=====-=-==- --=- ==-=-
http://arcgraph.de/sr/

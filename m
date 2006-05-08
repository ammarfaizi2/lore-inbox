Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWEHLNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWEHLNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWEHLNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:13:48 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:2037 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751156AbWEHLNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:13:47 -0400
Date: Mon, 8 May 2006 13:13:45 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060508111345.GA1875@harddisk-recovery.com>
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507095039.089ad37c.akpm@osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 09:50:39AM -0700, Andrew Morton wrote:
> This is probably because the number of pdflush threads slowly grows to its
> maximum.  This is bogus, and we seem to have broken it sometime in the past
> few releases.  I need to find a few quality hours to get in there and fix
> it, but they're rare :(
> 
> It's pretty harmless though.  The "load average" thing just means that the
> extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> they'll later exit and clean themselves up.  They won't be consuming
> significant resources.

Not completely harmless. Some daemons (sendmail, exim) use the load
average to decide if they will allow more work. A local user could
create a mail DoS by just copying a couple of large files around.
Zeniv.linux.org.uk mail went down due to this. See
http://lkml.org/lkml/2006/3/28/70 .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263140AbTCSSxV>; Wed, 19 Mar 2003 13:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbTCSSxV>; Wed, 19 Mar 2003 13:53:21 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:20386 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263140AbTCSSxV>; Wed, 19 Mar 2003 13:53:21 -0500
Date: Wed, 19 Mar 2003 19:03:29 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1: eth0: Transmit error, Tx status register 90
Message-ID: <20030319190329.GA28277@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20030319013042.19266.qmail@linuxmail.org> <20030318191833.317fa459.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318191833.317fa459.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 07:18:33PM -0800, Andrew Morton wrote:

 > Is it slow with both scp and NFS?  Or just NFS?
 > 
 > If just NFS then yes, I see this too.  Transferring files 2.5->2.4 over NFS
 > is several times slower than 2.4->2.4 or 2.5->2.5.  Quite repeatable.

You could be hitting the same problems I saw a few weeks back.
Short: There were a *lot* of bogus UDP packets being transmitted.
Trond took a look at a tcpdump log of bad traffic and found there
were all sorts of silly things in there like oversized frames etc.

I've not had time to look into this since then, but also see strange
effects of this bug like failing md5sums after copying over NFS.
 
		Dave


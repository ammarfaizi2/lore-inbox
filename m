Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272368AbTGaPEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272497AbTGaPEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:04:42 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:4877 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272368AbTGaPEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:04:41 -0400
Date: Thu, 31 Jul 2003 16:04:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] dm: decimal device num sscanf
Message-ID: <20030731160429.A14613@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <thornber@sistina.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk> <20030731104953.GG394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030731104953.GG394@fib011235813.fsnet.co.uk>; from thornber@sistina.com on Thu, Jul 31, 2003 at 11:49:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 11:49:53AM +0100, Joe Thornber wrote:
> The 2.4 version of Device-Mapper scans for device-numbers in decimal
> instead of hex (in dm_get_device()). Update 2.6 so both versions use
> the same behavior.  [Kevin Corry]

This code should just go away completly.  There's no excuse for parsing
a dev_t in new code instead of a pathname.


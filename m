Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272507AbTGaPPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272515AbTGaPOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:14:34 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:48142 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272507AbTGaPN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:13:26 -0400
Date: Thu, 31 Jul 2003 16:13:26 +0100
From: Joe Thornber <thornber@sistina.com>
To: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@sistina.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] dm: decimal device num sscanf
Message-ID: <20030731151326.GZ394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk> <20030731104953.GG394@fib011235813.fsnet.co.uk> <20030731160429.A14613@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731160429.A14613@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 04:04:30PM +0100, Christoph Hellwig wrote:
> On Thu, Jul 31, 2003 at 11:49:53AM +0100, Joe Thornber wrote:
> > The 2.4 version of Device-Mapper scans for device-numbers in decimal
> > instead of hex (in dm_get_device()). Update 2.6 so both versions use
> > the same behavior.  [Kevin Corry]
> 
> This code should just go away completly.  There's no excuse for parsing
> a dev_t in new code instead of a pathname.

It's in there to match the output from 'dmsetup table'.  I'm not sure
anyone uses it, but I'd still like to keep it so that 2.4 and 2.6 stay
in sync.

- Joe

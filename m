Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbTCGX0H>; Fri, 7 Mar 2003 18:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTCGX0G>; Fri, 7 Mar 2003 18:26:06 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:8967 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261886AbTCGX0G>; Fri, 7 Mar 2003 18:26:06 -0500
Date: Fri, 7 Mar 2003 23:36:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Cherry <cherry@osdl.org>
Cc: Randy Dunlap <rddunlap@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Joel.Becker@oracle.com, greg@kroah.com, akpm@digeo.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307233636.A19260@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Cherry <cherry@osdl.org>, Randy Dunlap <rddunlap@osdl.org>,
	Joel.Becker@oracle.com, greg@kroah.com, akpm@digeo.com,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307225517.GF2835@ca-server1.us.oracle.com> <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1047080297.10926.180.camel@cherrytest.pdx.osdl.net>; from cherry@osdl.org on Fri, Mar 07, 2003 at 03:38:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:38:18PM -0800, John Cherry wrote:
> Sure. You could grab unassigned majors...if that is what you want to
> do.  There are a number of ways to "get around" the lack of minor
> numbers.  None of them follow conventional thinking with regards to
> major/minor usage.

If you actually looked at the block layer code instead of just talking
along you'd see that the major/minor split has absolutely zero meaning
for the actual driver interface in 2.5.  The only major numbers have
any meanting to is pretty printing (/proc/devices and __bdevname).


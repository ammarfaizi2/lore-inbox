Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262399AbTCZTwy>; Wed, 26 Mar 2003 14:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbTCZTwy>; Wed, 26 Mar 2003 14:52:54 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:31494 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262399AbTCZTwu>; Wed, 26 Mar 2003 14:52:50 -0500
Date: Wed, 26 Mar 2003 20:04:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
Message-ID: <20030326200402.A21308@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <OF80FD93D6.AA8C5DBA-ONC1256CF5.00589668@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF80FD93D6.AA8C5DBA-ONC1256CF5.00589668@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Mar 26, 2003 at 05:20:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> s390 and s390x are similar at the first glance. But if you look in detail
> you will notice that there are a lot of small differences. A simple diff
> of the files that are present in both arch folger gives a patch of 5600
> lines.

Now actually take a look at this diff :)  The biggest part is that the
s390 compat files exist only on s390x and the math-emu dir only exists
on s390, that's just a matter of conditionally compiling the files.

Then there's of course slightly different assembly, this is just different
but can be abstracted out nicely.  In C code there's lots of spurious
differences that don't make any sense (like using the proper type on s390x
but soething that doesn't matter on s390, commenting changes, etc..).

There's still some real differences of course, but it's really a small
amount of the code size.



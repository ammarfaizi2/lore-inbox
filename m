Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTBLELF>; Tue, 11 Feb 2003 23:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTBLELF>; Tue, 11 Feb 2003 23:11:05 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:9856 "EHLO bjl1.jlokier.co.uk")
	by vger.kernel.org with ESMTP id <S261448AbTBLELE>;
	Tue, 11 Feb 2003 23:11:04 -0500
Date: Wed, 12 Feb 2003 04:21:43 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>, ak@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212042143.GB9273@bjl1.jlokier.co.uk>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212025902.GA14092@codemonkey.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> I feel I'm missing something obvious here, but is this part the
> low-hanging fruit that it seems ?

You have eliminated one MSR write very cleanly, although there are
still a few unnecessary conditionals when compared with grabbing a
whole branch of the fruit tree, as it were.

That leaves the other MSR write, which is also unnecessary.

-- Jamie

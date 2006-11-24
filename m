Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933467AbWKXVmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933467AbWKXVmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934494AbWKXVmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:42:32 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:9140 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S933467AbWKXVmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:42:31 -0500
Date: Fri, 24 Nov 2006 21:42:18 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Andreas Koensgen <ajk@iehk.rwth-aachen.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 6pack: fix "&= !" typo
Message-ID: <20061124214218.GA13168@linux-mips.org>
References: <20061122225856.GB10758@1wt.eu> <20061124185816.GB4973@martell.zuzino.mipt.ru> <20061124202153.GA11858@linux-mips.org> <20061124212306.GA1736@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124212306.GA1736@1wt.eu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 10:23:06PM +0100, Willy Tarreau wrote:

> One more reason to perform more code reviews helped with automated tools.
> We found this one and the rio's one while discussing with Jean Delvare
> about such bugs, and firing a random grep to illustrate how easy it could
> be to spot bugs similar to Alexey's "&&" instead of "&" ...
> 
> I think that we should at least take a look at all lines in the pre-processed
> code having both '!' and '&' on the same line. There are a lot of them, but
> divided by a sufficient number of volunteers, we might catch a bunch of them.
> 
> BTW, has anyone a good idea on how to make gcc dump the preprocessed files
> for everything it builds ? I mean, just by changing some variables in the
> Makefile.

It seems to might be about to re-invent sparse which is probably the
right framework for such semantic tests.

  Ralf

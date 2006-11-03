Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWKCKS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWKCKS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 05:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbWKCKS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 05:18:57 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:35049 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1752809AbWKCKS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 05:18:56 -0500
Date: Fri, 3 Nov 2006 11:19:01 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061103101901.GA11947@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 November 2006 02:19:05 +0100, Mikulas Patocka wrote:
> >On Thu, 2 November 2006 22:52:47 +0100, Mikulas Patocka wrote:
> >>
> >>new method to keep data consistent in case of crashes (instead of
> >>journaling),
> >
> >Your 32-bit transaction counter will overflow in the real world.  It
> >will take a setup with millions of transactions per second and even
> >then not trigger for a few years, but when it hits your filesystem,
> >the administrator of such a beast won't be happy at all. :)
> 
> If it overflows, it increases crash count instead. So really you have 2^47 
> transactions or 65536 crashes and 2^31 transactions between each crash.

I am fully aware the counters are effectively 48-bit.  If they were
just 32-bit, you would likely have hit the problem yourself already.

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law

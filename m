Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTEDSlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTEDSlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:41:39 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:51462 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261564AbTEDSlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:41:37 -0400
Date: Sun, 4 May 2003 19:54:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] Update sk98lin driver
Message-ID: <20030504195405.A24981@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	KML <linux-kernel@vger.kernel.org>
References: <1052073847.4478.18.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052073847.4478.18.camel@nosferatu.lan>; from azarah@gentoo.org on Sun, May 04, 2003 at 08:44:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 08:44:07PM +0200, Martin Schlemmer wrote:
> Anyhow, I got the new to compile, and fixed the few irqreturn_t
> calls, and some other 2.5 changes I knew about.
> 
> Now the problem is that if I try to load it, I get this:
> 
> -----------------------------------------
> sk98lin: Unknown symbol __udivdi3
> -----------------------------------------
> 
> Meaning it linked with libgcc_s.so.  Any ideas why ?

Get rid of division on 64bit types in the driver.


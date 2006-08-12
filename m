Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWHLWlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWHLWlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWHLWlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:41:06 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:33982 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S964951AbWHLWlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:41:05 -0400
Date: Sat, 12 Aug 2006 23:41:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, wim@iguana.be,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060812224100.GA9043@linux-mips.org>
References: <200608102319.13679.thomas@koeller.dyndns.org> <1155326835.24077.116.camel@localhost.localdomain> <200608121806.02844.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608121806.02844.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 06:06:02PM +0200, Thomas Koeller wrote:

> > > +	while (1) continue;
> >
> > cpu_relax();
> 
> I tried to find out about the purpose of cpu_relax(). On MIPS, at least,
> it maps to barrier(). I do not quite understand why I would need a
> barrier() in this place. Would you, or someone else, care to
> enlighten me?

Busy wait loops are meant to be filled with cpu_relax() in Linux.  On
processors like the Pentium 4 this expands into something that keeps
the CPU from consuming excessive amounts of energy for just twiddling
thumbs and probably also CPU dependant.  On MIPS cpu_relax() so far is
meaningless and therfore just defined as barrier().

  Ralf

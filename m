Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUJUQhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUJUQhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUJUQhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:37:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42460 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268902AbUJUQfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:35:24 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4177D163.2000503@techsource.com>
References: <4176E08B.2050706@techsource.com>
	 <1098313825.12374.74.camel@localhost.localdomain>
	 <4177D163.2000503@techsource.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098372761.17096.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 16:32:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 16:10, Timothy Miller wrote:
> > Essentially if you can do alpha, bitblit, blit from main memory and
> > a couple of fills and colour-expands X is happy.
> 
> How about text, stipple fills, tile fills, and lines?  :)

They really don't seem to matter much. Text is generally a colour expand
fill (ie mono -> colour bitmap expansion) or alpha blended fill.
Stipples and tiles are no big deal and angled lines are used very
little, and are also very cheap because they don't cause any pci fetches
except for weird stuff like xor lines. The main users of those do
horizontal/vertical only which means they are just rectangles...

Alan


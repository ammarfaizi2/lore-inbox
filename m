Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUIXLui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUIXLui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268699AbUIXLui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:50:38 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:61117 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268697AbUIXLug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:50:36 -0400
Date: Fri, 24 Sep 2004 21:50:18 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Walrond <andrew@walrond.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409241127.38529.rjw@sisk.pl>
Message-Id: <Pine.LNX.4.58.0409242143500.16306@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409240931.42356.andrew@walrond.org>
 <Pine.LNX.4.58.0409241856120.16011@fb07-calculator.math.uni-giessen.de>
 <200409241127.38529.rjw@sisk.pl>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Rafael J. Wysocki (RW) wrote:

RW> > my board has only four banks, each of them has a 1GB module sitting.
RW> > (page 26 of ftp://ftp.tyan.com/manuals/m_s2875_102.pdf)
RW> 
RW> Which is what makes the difference, I think.  IMO, the problem is that _both_ 
RW> CPUs use the same memory bank that is physically attached to only one of them 
RW> which leads to conflicts, apparently (the CPU with memory has also 
RW> PCI/AGP/whatever attached to it via HyperTransport so I can imagine there may 
RW> be issues with overlapping address spaces etc.).  I'd bet that there's 
RW> something wrong either with the BIOS or with the board design itself and I 
RW> don't think there's anything that the kernel can do about it (usual 
RW> disclaimer applies).

I got the impression that the whole point of the problem is that the
kernel is getting some wrong information about the memory configuration.

Is there any way to check which information exactly is wrong that leads to
the error and to see after that, where this information comes from: if the
BIOS is lying or if the kernel is misinterpreting something...



        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain

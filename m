Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUFZX61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUFZX61 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267239AbUFZX61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:58:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:184 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267238AbUFZX6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:58:16 -0400
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
In-Reply-To: <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>
	 <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	 <20040626221802.GA12296@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1088290477.3790.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Jun 2004 23:54:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-06-26 at 23:48, Linus Torvalds wrote:
> "jiffies" is one of the few things that I accept as volatile, since it's 
> basically read-only and accessed directly and has no internal structure 
> (ie it's a single word).

For most uses jiffies should die. If drivers could not access jiffies
except by a (possibly trivial) helper then it would be a huge step
closer to being able to run embedded linux without a continually running
timer.



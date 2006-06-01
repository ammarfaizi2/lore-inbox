Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWFAMzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWFAMzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 08:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWFAMzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 08:55:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23687 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750918AbWFAMzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 08:55:05 -0400
Subject: Re: 2.6.17-rc5-mm2 md cause BUGs, and readahead speedup
From: Arjan van de Ven <arjan@infradead.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <447EDF09.5040807@aitel.hist.no>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <447EDF09.5040807@aitel.hist.no>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 14:54:59 +0200
Message-Id: <1149166500.3115.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 14:35 +0200, Helge Hafting wrote:
> The good stuff first, bootup went from 55s to 43s according to 
> bootchart. :-)
> Probably the readahead stuff.
> 
> I got some BUG messages in dmesg though, they
> seem related to md initialization:
> 
> Freeing unused kernel memory: 236k freed
> md: Autodetecting RAID arrays.
> BUG: warning at fs/block_dev.c:944/do_open()

we're working on fixing this already; the warning appears to be an
over-eager assert but we need to validate that some more first


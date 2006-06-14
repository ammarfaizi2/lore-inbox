Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWFNK1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWFNK1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFNK1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:27:47 -0400
Received: from canuck.infradead.org ([205.233.218.70]:1931 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932212AbWFNK1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:27:46 -0400
Subject: Re: Panic in simple_map_write called from cfi_probe_chip
From: David Woodhouse <dwmw2@infradead.org>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, info@crossnet.co.jp
In-Reply-To: <1150280036.6482.7.camel@alice>
References: <1150280036.6482.7.camel@alice>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 11:26:17 +0100
Message-Id: <1150280777.3176.67.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 12:13 +0200, Eric Sesterhenn wrote:
> I decided to play around with all the new shiny stuff in 2.6.17-rc6-mm2,
> and tried to build a nearly allyesconfig kernel. After some tries,
> I got to the point where it still runs after uncompressing, and got
> into a panic.
> 
> [   31.270647] Photron PNC-2000 flash mapping: 400000 at bf000000
> [   31.270737] BUG: unable to handle kernel paging request at virtual address bf000000 

Yeah. The Photron PNC-2000 mapping assumes that the flash was already
mapped. I'm not entirely sure why it does that. I'm also vaguely
surprised that it's an x86 device -- for some reason I thought it was
MIPS, which would have made bf000000 make a lot more sense.

-- 
dwmw2


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWCLJDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWCLJDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 04:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWCLJDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 04:03:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20917 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751212AbWCLJDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 04:03:06 -0500
Date: Sun, 12 Mar 2006 09:03:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc6
Message-ID: <20060312090305.GA18134@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 03:58:12PM -0800, Linus Torvalds wrote:
> Bjorn Helgaas:
>       [IA64] don't report !sn2 or !summit hardware as an error
>       [IA64] SGI SN drivers: don't report !sn2 hardware as an error

These should be reverted.  They return success from initcalls when they
should report failure.  In the mmtimer case this is a real bug as it can
be modular, in others it's just cosmetic but provides people wrong examples
to cut & paste from.


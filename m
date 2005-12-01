Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVLALdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVLALdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVLALdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:33:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932148AbVLALdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:33:41 -0500
Date: Thu, 1 Dec 2005 11:33:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>, Franck <vagabon.xyz@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051201113339.GF3958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <cda58cb80511300821y72f3354av@mail.gmail.com> <20051130162327.GC1053@flint.arm.linux.org.uk> <cda58cb80511300845j18c81ce6p@mail.gmail.com> <20051130165546.GD1053@flint.arm.linux.org.uk> <1133374482.4117.91.camel@baythorne.infradead.org> <20051130190224.GE1053@flint.arm.linux.org.uk> <1133426199.4117.179.camel@baythorne.infradead.org> <20051201094111.GA14726@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201094111.GA14726@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 09:41:11AM +0000, Russell King wrote:
> In which case why do we restrict floppy to only those machines which
> could have floppy?

Because the floopy drivers needs asm/floppy.h and wouldn't build on others.

> Why do we restrict IDE to only those platforms
> which may have IDE?

Dito with asm/ide.h

these are very old drivers where people weren't used to abstractions that
would allow to write them platform-independent.  For any driver that doesn't
have an actual platform depency making it conditional is a bad idea.


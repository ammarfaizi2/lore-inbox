Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUF1Hyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUF1Hyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUF1Hyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:54:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63243 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264881AbUF1Hyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:54:38 -0400
Date: Mon, 28 Jun 2004 08:54:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628085429.C32206@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
References: <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com> <20040626235248.GC12761@taniwha.stupidest.org> <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com> <20040628003311.GA23017@taniwha.stupidest.org> <20040628021439.A17654@flint.arm.linux.org.uk> <20040628014443.GA24247@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628014443.GA24247@taniwha.stupidest.org>; from cw@f00f.org on Sun, Jun 27, 2004 at 06:44:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 06:44:43PM -0700, Chris Wedgwood wrote:
> On Mon, Jun 28, 2004 at 02:14:39AM +0100, Russell King wrote:
> > It's the way its always been done, and the way the tty layer works.
> > You register a range of ttys that you're going to be driving, and
> > you own those ttys whether or not you actually have hardware for
> > them.
> 
> How about this (yes, it's a hack but it's really not that bad and will
> get things working until we can fix this up in 2.7.x):

If you're going to do that, why not just disable 8250 in the kernels
configuration?  It has exactly the same effect.  With the change you
propose, you can't even use 8250 for PCMCIA serial cards.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

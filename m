Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbTGUMYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbTGUMYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:24:34 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:61193 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270022AbTGUMXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:23:05 -0400
Date: Mon, 21 Jul 2003 13:37:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Javier Achirica <achirica@telefonica.net>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Mike Kershaw <dragorn@melchior.nerv-un.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
Message-ID: <20030721133757.A24319@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Javier Achirica <achirica@telefonica.net>,
	Daniel Ritz <daniel.ritz@gmx.ch>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-net <linux-net@vger.kernel.org>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Mike Kershaw <dragorn@melchior.nerv-un.net>
References: <200307180015.16687.daniel.ritz@gmx.ch> <Pine.SOL.4.30.0307211252190.25549-100000@tudela.mad.ttd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.30.0307211252190.25549-100000@tudela.mad.ttd.net>; from achirica@telefonica.net on Mon, Jul 21, 2003 at 01:00:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:00:54PM +0200, Javier Achirica wrote:
> 
> Daniel,
> 
> Thank you for your patch. Some comments about it:
> 
> - I'd rather fix whatever is broken in the current code than going back to
> spinlocks, as they increase latency and reduce concurrency. In any case,
> please check your code.

In general we prefer spinlocks in linux for drivers unless there's a
very good reason against it.  If you have latency or concurrency problems
it seems you have problems with your algorithms or the length of your
critical sections.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVFUINB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVFUINB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVFUIMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:12:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19340 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261660AbVFUGw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:52:27 -0400
Date: Tue, 21 Jun 2005 07:52:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: PATCH: Fix crashes with hotplug serverworks
Message-ID: <20050621065221.GA31420@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
References: <1119298859.3325.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119298859.3325.43.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:21:13PM +0100, Alan Cox wrote:
> You can't install the base kernel on a Stratus box because of the
> overuse of __init. Affects both IDE layers identically. It isn't the
> only misuser of __init so more review of other drivers (or fixing
> ide_register code to know about hotplug v non-hotplug chipsets) would be
> good.

Well, because of fake-hotplug we really need to mark every ->probe routine
and what's called from it __devinit.  Debian has patch to do that forever
but Bart refused to take it.


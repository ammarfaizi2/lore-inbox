Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTIDMzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTIDMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:55:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50349 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264966AbTIDMyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:54:38 -0400
Date: Thu, 4 Sep 2003 05:43:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, paulus@samba.org, rmk@arm.linux.org.uk,
       hch@lst.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904054357.0f17d860.davem@redhat.com>
In-Reply-To: <3F573323.10604@pobox.com>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<1062671669.21777.9.camel@dhcp23.swansea.linux.org.uk>
	<3F573323.10604@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Sep 2003 08:42:11 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> ioremap() has long wanted a struct pci_dev argument too.
> (or make that struct device, now)

I majorly disagree.

If you can't do it with a resource/offset/len triple,
a struct device isn't going to help you much more.

If you need to get at the device, you can convert the
resource to the controller address range or even encode
the controller domain number in the resource somehow.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTIDKnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTIDKnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:43:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60588 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264899AbTIDKnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:43:04 -0400
Date: Thu, 4 Sep 2003 03:33:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: paulus@samba.org, rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904033324.3d7139d9.davem@redhat.com>
In-Reply-To: <1062671669.21777.9.camel@dhcp23.swansea.linux.org.uk>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<1062671669.21777.9.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Sep 2003 11:34:30 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Iau, 2003-09-04 at 10:36, David S. Miller wrote:
> > You only need a resource in order to do this.  Then you can
> > stick the upper bits, controller number, whatever in the unused
> > resource flag bits.
> 
> If it becomes the default approach over time then we also need a 
> version that allows offset/len to be included for mapping parts
> of very large objects (like 256Mb frame buffers)

The implication was that the args would be:

	resource, offset, len

which would give what you want.

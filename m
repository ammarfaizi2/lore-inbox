Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVFUKCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVFUKCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 06:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVFUKAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 06:00:00 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:46810 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262063AbVFUJ71 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:59:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7nNYnfu+HWonTOnyLuKa30sQt7A/uzb8DVFFNZez+cEZIn6zI1pFPegTvLR/HzC0UAur36MpAE0AtXXyntlJ+YYzKMPo0flqyVlBRa7Rn5BTfqd3uAvfT+2bvEcPd2jfkkC9bd/YyA47tekiIhNx0dShFqFUtkcHWVca+qvPGA=
Message-ID: <58cb370e0506210259669c912d@mail.gmail.com>
Date: Tue, 21 Jun 2005 11:59:22 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Fix crashes with hotplug serverworks
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <1119346417.3325.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119298859.3325.43.camel@localhost.localdomain>
	 <20050621065221.GA31420@infradead.org>
	 <1119346417.3325.82.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-06-21 at 07:52, Christoph Hellwig wrote:
> > Well, because of fake-hotplug we really need to mark every ->probe routine
> > and what's called from it __devinit.  Debian has patch to do that forever
> > but Bart refused to take it.
> 
> I'm not surprised from our experience either.

Get a life.

> Actually marking all the devices __devinit may be overkill. One approach
> that does also seem to work is passing "hotplug yes/no" information when
> registering the driver. This is then used to run the ide scan at boot
> and avoid registering that driver with the PCI core for hotplug.

* with fake-hotplug driver you always need "hotplug yes"
* these drivers have to be registered with PCI core

> A move to __devinit is certainly simpler.

This is a correct fix.

Bartlomiej

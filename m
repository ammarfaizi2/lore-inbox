Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVFUIaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVFUIaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVFUI1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:27:02 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:29143 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262090AbVFUIZJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tfredsk0TwJoEczu3gSyKXAqtz/ShgGOcjpew5QNLrs/4rxkeRQYkCj7Lc+tBXNvPYb2Fmttl1VTnkV3pMz4t/TPsZmUsm2KKmX6Ctj4EIDqqhk/tv0g5S4CIigrMcbMnqOWHXtRnm4CeZaoDnE8q38I8oebqv2XHS6s/RRFkpU=
Message-ID: <58cb370e050621012538018e0@mail.gmail.com>
Date: Tue, 21 Jun 2005 10:25:08 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: PATCH: Fix crashes with hotplug serverworks
In-Reply-To: <20050621065221.GA31420@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119298859.3325.43.camel@localhost.localdomain>
	 <20050621065221.GA31420@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 20, 2005 at 09:21:13PM +0100, Alan Cox wrote:
> > You can't install the base kernel on a Stratus box because of the
> > overuse of __init. Affects both IDE layers identically. It isn't the
> > only misuser of __init so more review of other drivers (or fixing
> > ide_register code to know about hotplug v non-hotplug chipsets) would be
> > good.
> 
> Well, because of fake-hotplug we really need to mark every ->probe routine
> and what's called from it __devinit.  Debian has patch to do that forever
> but Bart refused to take it.

If you care to respin your big patch it I'll gladly take it.
It is indeed needed for PCI hotplug.

Bartlomiej

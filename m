Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVHPKCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVHPKCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVHPKCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:02:06 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:38677 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965184AbVHPKCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:02:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShIA9lFUHBS4hvcz4s87De/XdC59ZT5v1ePtqzm2KMqdGfJhzKgThJa0lmbO7YVh8WgM8wfnWCN6iOzU3IoPR6r37T9yVfjj68XpTEHe8PnfRhS7KPl8EMz8FAbMLpVL1qo8rgRHhhUBkXpxGcV4kC9+qfhp4dyCBcXnRLZn954=
Message-ID: <58cb370e050816030248e6283c@mail.gmail.com>
Date: Tue, 16 Aug 2005 12:02:00 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
In-Reply-To: <20050811203437.GA9265@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <20050811203437.GA9265@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> > IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> > around in I/O port space.  Poking at things that don't exist causes MCAs
> > on HP ia64 systems.
> 
> Maybe it should instead depend on those systems where it is available.
> Anything but X86?

Don't forget that arch specific drivers use IDE_GENERIC *indirectly*
to probe for devices.

Bartlomiej

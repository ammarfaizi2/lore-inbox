Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVA1TeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVA1TeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVA1T3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:29:45 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:5578 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262794AbVA1T0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:26:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OsbuD4XL1Tw7Mc6VzGK+3speSYWn8kjdqnT6Ey7Wwd8MFDWQJ1f7P3/KR0YZuNfupM7cIDFqXYqO9qHTciqzJqv/QD4M5ksmmLFUIbu4Vkaakb+Er8OF2JrAQcxOgYykGex3Q6pZMSlJTtniZFtbfaFtGdtDkjoJLAQtm9LiKM8=
Message-ID: <9e4733910501281126423ed066@mail.gmail.com>
Date: Fri, 28 Jan 2005 14:26:40 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Cc: Jesse Barnes <jbarnes@sgi.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050128191549.GA32135@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <20050125042459.GA32697@kroah.com>
	 <9e473391050127015970e1fedc@mail.gmail.com>
	 <200501270828.43879.jbarnes@sgi.com>
	 <20050128173222.GC30791@colo.lackof.org>
	 <9e47339105012810362a0a7018@mail.gmail.com>
	 <20050128191549.GA32135@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 12:15:49 -0700, Grant Grundler
<grundler@parisc-linux.org> wrote:
> I don't care if it gets fixed (or not) since I don't use
> or need to support multiple VGA cards. If someone else (in

Next year we are going to see a lot of multiple VGAs. Depending on
configuration the Nvidia4 chipset can support from one up to eight PCI
Express video cards simultaneously.

I would like to get this fixed in the kernel so that apps like X won't
do it from user space. Every time X does a read/alter/write to PCI
config space from user space is a place where bad things can happen.
The goal of this is to remove the PCI bus probing code from X.

-- 
Jon Smirl
jonsmirl@gmail.com

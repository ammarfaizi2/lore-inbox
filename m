Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUJMPmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUJMPmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUJMPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:42:14 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56009 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269276AbUJMPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:42:09 -0400
Subject: Re: PATCH: IDE generic tweak
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@linux.kernel.org
In-Reply-To: <20041013153152.GA5458@havoc.gtf.org>
References: <1097677476.4764.9.camel@localhost.localdomain>
	 <20041013153152.GA5458@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097678363.4696.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 15:39:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-13 at 16:31, Jeff Garzik wrote:
> > Comments ?
> 
> nVidia and others have been pushing for a similar module for libata...
> at least make sure one doesn't preclude the other.

libata can't do ATAPI and doesn't know about PATA errata so it's not
useful in libata yet. The generic grabber will honour pci and io
resource allocations so the existing "borrow 0x170" stuff will do the
right thing.


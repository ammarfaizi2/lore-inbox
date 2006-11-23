Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933172AbWKWTjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbWKWTjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757456AbWKWTjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:39:08 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:24770 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1757453AbWKWTjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:39:07 -0500
Date: Thu, 23 Nov 2006 12:39:05 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 3/5] PCI : Add selected_regions funcs
Message-ID: <20061123193905.GD6083@parisc-linux.org>
References: <456404FE.1040708@jp.fujitsu.com> <200611232033.35280.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611232033.35280.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 08:33:32PM +0100, Ingo Oeser wrote:
> bitfields (and bitmask) should be unsigned and use machine word size,
> which is usually "long". So please pass them in "unsigned long" instead of "int".

Why?  We know how many BARs PCI devices have (6.  Plus ROM.  Plus 4
bridge resources, making 11).  We could even use a u16.  An int is fine,
there's no need to re-spin this patch.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030711AbWHILwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711AbWHILwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030712AbWHILwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:52:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:36063 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030711AbWHILwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:52:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps during resume
Date: Wed, 9 Aug 2006 13:51:06 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl> <200608091304.35746.rjw@sisk.pl> <20060809113335.GP3308@elf.ucw.cz>
In-Reply-To: <20060809113335.GP3308@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091351.06596.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:33, Pavel Machek wrote:
]--snip--[
> 
> I'm still not sure if highmem support is worth the complexity -- I
> hope highmem dies painful death in next 3 weeks or so.

metoo, but currently quite a lot of Core Duo-based notebooks with 1 GB of RAM
and more are still being sold, let alone the Celerons, Semprons etc.

The patch is designed so that the higmem-related parts are just dropped by the
compiler if CONFIG_HIGHMEM is not set.  That makes it a bit larger, but then
they don't get in the way when they are not needed.

[Well, I've been using 64-bit machines only for quite some time anyway, but
I thought it would be nice to do something for the others, too. ;-) ]

Rafael

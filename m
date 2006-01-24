Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWAXIVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWAXIVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWAXIVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:21:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42435 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932426AbWAXIVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:21:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] swsusp: use bytes as image size units
Date: Tue, 24 Jan 2006 09:22:33 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200601240032.26735.rjw@sisk.pl> <20060123235642.GD6924@redhat.com>
In-Reply-To: <20060123235642.GD6924@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240922.33637.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 January 2006 00:56, Dave Jones wrote:
> On Tue, Jan 24, 2006 at 12:32:26AM +0100, Rafael J. Wysocki wrote:
>  > Hi,
>  > 
>  > This patch makes swsusp use bytes as the image size units, which is needed
>  > for future compatibility.
> 
> With what ?

WIth the userland interface.

> I don't see how clipping this range to a maximum of 4GB 
> will future-proof anything. What happens in a few years time when
> I want to suspend my 8GB laptop ?

We cannot create an image that's greater than 1/2 of RAM (in general)
or 1/2 of lowmem (on i386) anyway, but this does not limit the size of
RAM of a box you want to suspend.  The rest of the RAM contents will
be swapped out before suspend.

Besides on x86-64 unsigned long is 64-bit, so it's not limited to 4 GB.

Greetings,
Rafael

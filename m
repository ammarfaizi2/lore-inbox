Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUIOVKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUIOVKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUIOVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:06:34 -0400
Received: from peabody.ximian.com ([130.57.169.10]:44739 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267516AbUIOVCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:02:46 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915205643.GA19875@hockin.org>
References: <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
	 <1095280414.23385.108.camel@betsy.boston.ximian.com>
	 <20040915204754.GA19625@hockin.org>
	 <1095281358.23385.109.camel@betsy.boston.ximian.com>
	 <20040915205643.GA19875@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 17:01:43 -0400
Message-Id: <1095282103.23385.112.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 13:56 -0700, Tim Hockin wrote:

> If you're notifying me of mounts and unmounts, I really want to know about
> all of them, not just mounts that have a hard local device.  I'd rather
> get "something was mounted" and be forced to probe that (that's a leak,
> too, but less important).

If its a big deal, we can use a generic kobject instead of the physical
device, but I don't think it is a big deal.

It is technically not a security issue, anyhow, since the kevent
requires root to read.  But I suppose most uses are going to shovel all
the events onto a user visible bus and we don't want to do arbitration
in user-space.

	Robert Love



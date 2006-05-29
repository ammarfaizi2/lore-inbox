Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWE2AgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWE2AgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWE2AgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:36:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751081AbWE2AgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:36:01 -0400
Date: Sun, 28 May 2006 17:40:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Dickson <dickson@permanentmail.com>
Cc: lkml@rtr.ca, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell
 Inspiron 6000
Message-Id: <20060528174011.94192282.akpm@osdl.org>
In-Reply-To: <20060528172101.a1b9725e.dickson@permanentmail.com>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<1148850683.3074.72.camel@laptopd505.fenrus.org>
	<20060528142951.2a7417cb.dickson@permanentmail.com>
	<447A1AEF.3040900@rtr.ca>
	<20060528172101.a1b9725e.dickson@permanentmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 17:21:01 -0700
Paul Dickson <dickson@permanentmail.com> wrote:

> I still get the BUG message on resuming that I reported in bugzilla
> comment #9:
>     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108#c9
> It is likely a separate bug.

That's ACPI doing a GFP_KERNEL allocation while resume has disabled
interrupts.  It won't cause much trouble and I'm pretty sure we
subsequently fixed that.


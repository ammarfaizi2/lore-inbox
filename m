Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWFZQOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWFZQOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFZQOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:14:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWFZQOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:14:15 -0400
Date: Mon, 26 Jun 2006 09:14:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PM_TRACE corrupts RTC
Message-Id: <20060626091413.a15df2e0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606260851000.3747@g5.osdl.org>
References: <20060625232322.af3f4f6c.akpm@osdl.org>
	<Pine.LNX.4.64.0606260851000.3747@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 08:52:57 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 25 Jun 2006, Andrew Morton wrote:
> > 
> > On a Sony Vaio, after a suspend-to-disk and a resume, `hwclock' says
> > 
> >   The Hardware Clock registers contain values that are either invalid
> >   (e.g.  50th day of month) or beyond the range we can handle (e.g.  Year
> >   2095).
> > 
> > and after a reboot the machine takes a trip back to 1969.  Setting
> > CONFIG_PM_TRACE=n prevents this.
> 
> That's how it works. It's by design. The RTC is where the trace events are 
> stored, since that's the only piece of hw that reliably survives a reboot.

Oh, I thought it found some spare space in there somehow.

Making it `default y' was a bit unfriendly.  How's about `default n' and
`depends on EMBEDDED'?

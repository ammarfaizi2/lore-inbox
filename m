Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUFVR0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUFVR0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUFVRXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:23:40 -0400
Received: from [213.146.154.40] ([213.146.154.40]:905 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265015AbUFVRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:20:29 -0400
Date: Tue, 22 Jun 2004 18:20:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-ID: <20040622172025.GA6074@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200405312218.i4VMIISg012277@harpo.it.uu.se> <20040622015311.561a73bf.akpm@osdl.org> <20040622085901.GA31971@infradead.org> <20040622020417.0ec87564.akpm@osdl.org> <20040622091219.GA32146@infradead.org> <20040622021441.4f6aa13c.akpm@osdl.org> <20040622091850.GA32160@infradead.org> <20040622022023.1942fd82.akpm@osdl.org> <16600.17486.81041.111276@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16600.17486.81041.111276@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:38:06PM +0200, Mikael Pettersson wrote:
> Swiching to open() on /proc/<pid>/<tid>/perfctr followed by ioctl()s
> would be easy to implement. But people @ LKML are sometimes violently
> opposed to ioctl()s, that's why the switch to syscalls happended.

I don't remember the details anymore, but lots of the syscalls could
really be read/write on special files.  I'll look through the code again
and send out draft API document.

> One concern is that there doesn't appear to be a user-visible shortcut
> to "your own" /proc/<pid>/<tid>/ like there was when /proc/self still
> had some useful meaning. This is merely annoying, not a show-stopper.

Shouldn't be a real problem to add one.

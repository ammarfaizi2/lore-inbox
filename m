Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVDHFFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVDHFFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVDHFFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:05:03 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:27057 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262671AbVDHFFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:05:00 -0400
X-ORBL: [68.120.153.162]
Date: Thu, 7 Apr 2005 22:04:58 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408050458.GB8720@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:

> Yes. The silly thing is, at least in my local tests it doesn't
> actually seem to be _doing_ anything while it's slow (there are no
> system calls except for a few memory allocations and
> de-allocations). It seems to have some exponential function on the
> number of pathnames involved etc.

I see lots of brk calls changing the heap size, up, down, up, down,
over and over.

This smells a bit like c++ new/delete behavior to me.

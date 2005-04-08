Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVDHFPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVDHFPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVDHFPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:15:23 -0400
Received: from hera.kernel.org ([209.128.68.125]:57264 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262689AbVDHFOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:14:42 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Kernel SCM saga..
Date: Fri, 8 Apr 2005 05:14:28 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d353vk$72m$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408050458.GB8720@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1112937268 7255 127.0.0.1 (8 Apr 2005 05:14:28 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 8 Apr 2005 05:14:28 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050408050458.GB8720@taniwha.stupidest.org>
By author:    Chris Wedgwood <cw@f00f.org>
In newsgroup: linux.dev.kernel
>
> On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:
> 
> > Yes. The silly thing is, at least in my local tests it doesn't
> > actually seem to be _doing_ anything while it's slow (there are no
> > system calls except for a few memory allocations and
> > de-allocations). It seems to have some exponential function on the
> > number of pathnames involved etc.
> 
> I see lots of brk calls changing the heap size, up, down, up, down,
> over and over.
> 
> This smells a bit like c++ new/delete behavior to me.
> 

Hmmm... can glibc be clued in to do some hysteresis on the memory
allocation?

	-hpa

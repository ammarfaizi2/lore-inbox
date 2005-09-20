Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVITPgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVITPgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVITPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:36:18 -0400
Received: from kanga.kvack.org ([66.96.29.28]:53672 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965040AbVITPgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:36:17 -0400
Date: Tue, 20 Sep 2005 11:35:25 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel error in system call accept() under kernel 2.6.8
Message-ID: <20050920153525.GJ32751@kvack.org>
References: <43301BC4.9080305@wincor-nixdorf.com> <20050920150755.GH32751@kvack.org> <433028A3.9090503@wincor-nixdorf.com> <20050920152850.GI32751@kvack.org> <43302BA1.5090109@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43302BA1.5090109@wincor-nixdorf.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 05:32:49PM +0200, Peter Duellings wrote:
> Right. But before Log.Log is called arguments of methods are
> copied on the stack. That means, also the current content of
> errno is copied. And "current" means in that case before the call
> to Log.Log is performed (errno is transferred by value - not by
> reference).

And strerror_r() modifies errno.  You can't rely on the order arguments 
to functions are evaluated in.

		-ben

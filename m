Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWAOTYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWAOTYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAOTYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:24:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750810AbWAOTYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:24:21 -0500
Subject: Re: string to inode conversion
From: Arjan van de Ven <arjan@infradead.org>
To: "pablo.ferlop@gmail.com" <pablo.ferlop@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137351430.11284.2.camel@localhost.localdomain>
References: <1137351430.11284.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 20:24:14 +0100
Message-Id: <1137353054.3230.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-15 at 19:57 +0100, pablo.ferlop@gmail.com wrote:
> Hi
> 
> I was wondering how I can get from a string with a path like "/home" or
> "/lib/libc-2.3.5.so" a struct inode.

which namespace do you want this in? The init one? or the one from the
user? (most traditional linux distributions only have one namespace, but
now that COW namespaces are merged I expect distros to start
experimenting with per user /tmp, or per-daemon data etc etc)

This is not a trivial thing... you need a "context" into which you can
ask that question (basically a process)


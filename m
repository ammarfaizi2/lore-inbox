Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUC2Tym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUC2Tym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:54:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45708 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262914AbUC2Tyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:54:41 -0500
Date: Mon, 29 Mar 2004 21:54:35 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] silence nfs mount messages
Message-ID: <20040329195435.GA19426@apps.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl> <1080587480.2410.61.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1080587480.2410.61.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 02:11:20PM -0500, Trond Myklebust wrote:

> På må , 29/03/2004 klokka 14:00, skreiv Andries.Brouwer@cwi.nl:
> > People complain about the kernel messages when mounting NFS.
> > (Just like last time a new NFS version was introduced.)
> > It is perfectly normal to have mount newer than the kernel,
> > or the kernel newer than mount. No messages are needed or useful.
> 
> I disagree...
> 
> We should fix the printk to be KERN_NOTIFY so that you can filter them,
> but otherwise there is *no way* to know whether or not you have support
> for the features you are attempting to use.
> People might get somewhat confused if they try to enable strong
> security, and the kernel happily mounts the partition with AUTH_SYS, and
> does nothing to warn them...

The features that are being used are used by layers of software.
If there is information to be passed, it should be passed to
that software, not printed in a syslog.
It is not the kernel's job to set policy and have an opinion about user mode setup.

Andries

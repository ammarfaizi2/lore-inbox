Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUC2TLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUC2TLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:11:48 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:45697 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263095AbUC2TLP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:11:15 -0500
Subject: Re: [patch] silence nfs mount messages
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andries.Brouwer@cwi.nl
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1080587480.2410.61.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 14:11:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 29/03/2004 klokka 14:00, skreiv Andries.Brouwer@cwi.nl:
> People complain about the kernel messages when mounting NFS.
> (Just like last time a new NFS version was introduced.)
> It is perfectly normal to have mount newer than the kernel,
> or the kernel newer than mount. No messages are needed or useful.

I disagree...

We should fix the printk to be KERN_NOTIFY so that you can filter them,
but otherwise there is *no way* to know whether or not you have support
for the features you are attempting to use.
People might get somewhat confused if they try to enable strong
security, and the kernel happily mounts the partition with AUTH_SYS, and
does nothing to warn them...

Cheers,
  Trond

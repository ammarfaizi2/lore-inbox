Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbUC2XYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUC2XYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:24:09 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:15490 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263170AbUC2XYH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:24:07 -0500
Subject: Re: [patch] silence nfs mount messages
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040329195435.GA19426@apps.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl>
	 <1080587480.2410.61.camel@lade.trondhjem.org>
	 <20040329195435.GA19426@apps.cwi.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1080602653.2410.192.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 18:24:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 29/03/2004 klokka 14:54, skreiv Andries Brouwer:

> The features that are being used are used by layers of software.
> If there is information to be passed, it should be passed to
> that software, not printed in a syslog.
> It is not the kernel's job to set policy and have an opinion about user mode setup.

What do you mean "setting policy"? Your program is attempting to use an
obsolete kernel ABI. Of course it should "have an opinion" about that...

The issue is merely whether or not to issue an EINVAL, in order to force
users to upgrade to an updated version of "mount":
For 2.7.x, I'm rather of a mind to do just that in order to finally
clean up the wretched struct nfs_mount and eliminate all the unused
backward-compatibilty crap, but doing so in the middle of 2.6.x is not
an option (particularly given that the SELinux mount changes came as
late as they did).

Cheers,
  Trond

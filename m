Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUJRS4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUJRS4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUJRSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:55:36 -0400
Received: from pat.uio.no ([129.240.130.16]:45023 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S267411AbUJRSsF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:48:05 -0400
Subject: Re: NFS4 client deadlock with 2.6.9-rc3-mm4 based kernel
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1098124066.13075.5.camel@leto.cs.pocnet.net>
References: <1098124066.13075.5.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1098125272.5744.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 20:47:52 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 18/10/2004 klokka 20:27, skreiv Christophe Saout:
> Hi,
> 
> I've managed to lock up the nfs4 client code in an nfs4 chroot
> environment.
> 
> I'm not sure but it seems that __rpc_execute has a problem when called
> recursively...?

Yes. Synchronous RPC calls should never be run by rpciod.

This is a known problem, and I'm working on a fix. I've already got
working code for nfs4_do_close(), but a similar scheme has be set up for
the byte range locking code.

At the moment I'm busy with my move from Norway to the US, so please
give me a week or 2 to get back to you on this one.

Cheers,
  Trond


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUJDSEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUJDSEX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUJDSCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:02:10 -0400
Received: from pat.uio.no ([129.240.130.16]:18828 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268378AbUJDSBx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:01:53 -0400
Subject: Re: [PATCH] lockd
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve Dickson <SteveD@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41617958.2020406@RedHat.com>
References: <41617958.2020406@RedHat.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096912891.22446.67.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 20:01:31 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 04/10/2004 klokka 18:24, skreiv Steve Dickson:
> Hey Neil,
> 
> Attached is a patch that fixes some potential SMP races
> in the lockd code that were identified by the SLEEP_ON_BKLCHECK
> that was (at one time) in the -mm tree...

Just for the record: the "SMP race condition" argument given here is
completely bogus. sleep_on_* is quite safe to use when the SMP races are
being handled using the BKL, as is the case here.

That said, I agree that the patch is of interest given the long term
goal of removing the BKL completely. Perhaps you could therefore also
amend your changelog entry text to reflect this motive?

Cheers,
  Trond


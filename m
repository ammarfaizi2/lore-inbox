Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUJDSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUJDSYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUJDSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:24:45 -0400
Received: from pat.uio.no ([129.240.130.16]:23734 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268268AbUJDSWs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:22:48 -0400
Subject: Re: [PATCH] lockd
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: arjanv@redhat.com
Cc: Steve Dickson <SteveD@redhat.com>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1096913608.2788.19.camel@laptop.fenrus.com>
References: <41617958.2020406@RedHat.com>
	 <1096912891.22446.67.camel@lade.trondhjem.org>
	 <1096913608.2788.19.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096914154.22446.73.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 20:22:34 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 04/10/2004 klokka 20:13, skreiv Arjan van de Ven:

> actually this triggered because there was NO bkl... if you hold the bkl
> the warning doesn't trigger.....

Then the fix is downright wrong.

We *must* be holding the BKL upon entry to nlmclnt_lock(). All sorts of
other things depend on it.

Cheers,
  Trond


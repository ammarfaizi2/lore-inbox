Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUAHQvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbUAHQvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:51:11 -0500
Received: from pat.uio.no ([129.240.130.16]:40893 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265563AbUAHQvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:51:08 -0500
Message-ID: <35311.68.42.103.198.1073580656.squirrel@webmail.uio.no>
Date: Thu, 8 Jan 2004 17:50:56 +0100 (CET)
Subject: Re: [NFS client] NFS locks not released on abnormal process termination
From: <trond.myklebust@fys.uio.no>
To: <yamamoto@valinux.co.jp>
In-Reply-To: <1073558844.242410.4086.nullmailer@yamt.dyndns.org>
References: <87llpms8yr.fsf@ceramic.fifi.org>
        <1073558844.242410.4086.nullmailer@yamt.dyndns.org>
X-Priority: 3
Importance: Normal
Cc: <phil@fifi.org>, <trond.myklebust@fys.uio.no>, <theonetruekenny@yahoo.com>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.11 - UIO)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.74, required 12,
	BAYES_00 -4.90, NO_REAL_NAME 0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> i think it's problematic because you can't assume the lock was
> granted on the server and the signaled process might not exit
> immediately.

The point is that it is *worse* to assume the lock was not granted,
since then it will never get cleared on the server.

The RPC layer blocks all signals except SIGKILL, so the signalled
process has no choice but to exit immediately if something gets
through.

Cheers,
  Trond



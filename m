Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVAVUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVAVUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVAVUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:05:59 -0500
Received: from pat.uio.no ([129.240.130.16]:10727 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262699AbVAVUFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:05:51 -0500
Subject: Re: Advise on: panic - Attempting to free lock with active block
	list
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Stuart Sheldon <stu@actusa.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41F1BBD1.8020304@actusa.net>
References: <41F1BBD1.8020304@actusa.net>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 15:05:41 -0500
Message-Id: <1106424341.10006.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.064, required 12,
	autolearn=disabled, AWL 0.01, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 21.01.2005 Klokka 18:34 (-0800) skreiv Stuart Sheldon:

> I had the same panic and screen error with a 2.6.9 PIII SMP system
> acting as an NFS client. This was after downgrading from a 2.6.10 kernel
> that was panic'ing in the same way. I reverted to 2.6.8 but left the
> Server (also a PIII SMP system) running 2.6.9. This occurred during
> moderate to heavy NFS activity. The patch referenced in
> http://seclists.org/lists/linux-kernel/2005/Jan/1237.html appeared to
> resolve the panic with 2.6.10, but I was having strange things happen,

That patch is already in 2.6.11-rc2.

> like failing to release file locks when the client reboots. This is a
> production system and needs to be available for users. I am currently
> trying to piece together another smp box to test with. I will post more
> if I can duplicate the problem on demand.

Failing to release file locks when the client reboots is not an NFS
client problem: that is handled entirely by the rpc.statd daemons and
the server. What kernel are you using on the server, and which version
of nfs-utils?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


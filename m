Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUKBQiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUKBQiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUKBQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:38:21 -0500
Received: from pat.uio.no ([129.240.130.16]:35028 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262389AbUKBQh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:37:28 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Brad Campbell <brad@wasp.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41877751.502@wasp.net.au>
References: <41877751.502@wasp.net.au>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 08:37:04 -0800
Message-Id: <1099413424.7582.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 02.11.2004 Klokka 16:02 (+0400) skreiv Brad Campbell:

> /raid 192.168.2.81(rw,async,no_root_squash)
> /raid 192.168.3.80(rw,async,no_root_squash)
> /raid0 192.168.2.81(rw,async,no_root_squash)
> /raid0/tmp 192.168.2.81(rw,async,no_root_squash)
> /raid2 192.168.2.81(rw,async,no_root_squash)
> /raid2 192.168.3.80(rw,async,no_root_squash)
> /nfsroot 192.168.2.81(rw,async,no_root_squash)

You should only have 1 line per directory.

You are not allowed to export a directory and its child (unless the
child is on a different partition - which does not appear to be the case
here).

  http://nfs.sourceforge.net/nfs-howto/server.html#CONFIG

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


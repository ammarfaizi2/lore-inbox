Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVALAqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVALAqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVALAoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:44:24 -0500
Received: from pat.uio.no ([129.240.130.16]:51673 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261196AbVALAlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:41:36 -0500
Subject: Re: Linux NFS vs NetApp
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1CoVZ2-0006f7-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1CoVZ2-0006f7-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 19:41:24 -0500
Message-Id: <1105490484.15912.51.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 12.01.2005 Klokka 00:36 (+0100) skreiv Bernd Eckenfels:

> However since also the read performance of Linux NFS is bad (at least not
> very well selftuning) the Hardware is not really the reason for the fast NFS
> implementation.

Indeed: NFS readahead requests are often processed out of order by the
server (due to the basic unordered nature of RPC calls, the lack of
ordering between nfsd server threads, use of UDP, etc) and so I suspect
the generic readahead algorithm will tend to default to the random
access mode in many cases where it should really be doing sequential
access.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


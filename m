Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVAURIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVAURIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVAURIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:08:15 -0500
Received: from pat.uio.no ([129.240.130.16]:1664 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262420AbVAURIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:08:13 -0500
Subject: Re: knfsd and append-only attribute:  "operation not permitted"
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Aaron D. Ball" <adb@bdi.com>
Cc: Vladimir Saveliev <vs@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <41F12C75.5040007@bdi.com>
References: <8381054C-6B13-11D9-BFA6-000D933B35AA@bdi.com>
	 <1106318654.3200.38.camel@tribesman.namesys.com>
	 <1106322787.30627.5.camel@lade.trondhjem.org>  <41F12C75.5040007@bdi.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 12:08:00 -0500
Message-Id: <1106327280.9849.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.004, required 12,
	autolearn=disabled, AWL 0.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 21.01.2005 Klokka 11:23 (-0500) skreiv Aaron D. Ball:

> OK, but that certainly shouldn't preclude read access.  The way it is 
> now, you can't even list append-only directories.  It seems like this 
> check should treat append-only files as read-only, only failing to open 
> them if write access is requested, rather than failing all the time like 
> it does now.

Agreed.

> In this particular case, I'm not using append-only files, but rather 
> using immutable files and append-only directories to create an archival 
> space where things can be added but not changed.  Even if the protocol 
> can't deal with append-only regular files, isn't it possible to allow 
> mkdir but not rmdir?

Append-only directories should be no problem as far as the protocol
goes, and neither should immutable files.

I suggest you take this bug to the NFS mailing list
nfs@lists.sourceforge.net or talk directly to the knfsd maintainer Neil
Brown (neilb@cse.unsw.edu.au).

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUKEC7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUKEC7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUKEC7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:59:35 -0500
Received: from pat.uio.no ([129.240.130.16]:33217 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262577AbUKEC70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:59:26 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jakob Oestergaard <jakob@unthought.net>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>,
       "Dr. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <418AE9DD.3010008@pobox.com>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
	 <20041102200925.GA12752@unthought.net>  <418AE9DD.3010008@pobox.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 18:59:01 -0800
Message-Id: <1099623541.25951.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 04.11.2004 Klokka 21:47 (-0500) skreiv Jeff Garzik:
> > 
> > Does running an 'ls' on the server in the exported directory that is
> > stale on the client resolve the problem (temporarily)?
> 
> Yes.

This still looks very much like a server issue to me. Could someone who
is seeing the bug try to capture an instance of the ESTALE error going
across the wire, and then do a fresh lookup of the same file from an
"ls" call. I'd like to check how the stale filehandle differs from the
freshly looked up one...

Please use "tcpdump -s 9000 -w /tmp/binary.pcap port 2049 and host
my.servers.name" for the actual capture.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


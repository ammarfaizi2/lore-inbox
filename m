Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUKCBPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUKCBPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKCBPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:15:51 -0500
Received: from pat.uio.no ([129.240.130.16]:63664 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261285AbUKCBNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:13:43 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41882414.2070003@drdos.com>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
	 <4187F69E.9020604@drdos.com> <1099431477.7854.21.camel@lade.trondhjem.org>
	 <20041102225304.GA11441@galt.devicelogics.com> <41882414.2070003@drdos.com>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 17:13:21 -0800
Message-Id: <1099444402.9957.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 02.11.2004 Klokka 17:19 (-0700) skreiv Jeff V. Merkey:

> >Connect 2.4.18 and 2.6.9 with NFS 3 enabled.  I am seeing problems 
> >connecting and file size mismatches.  I also see errors with zero
> >length files (host side) that get opened and populated with data
> >and the remote side is unable to read them -- keeps seeing 
> >them as zero length.  

That's entirely expected. NFS has always been forced to use a polling
model for attribute cache consistency. "man 5 nfs" and read all about
the "actimeo" mount options that control this behaviour.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


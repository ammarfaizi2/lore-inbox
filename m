Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUJCTW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUJCTW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 15:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJCTW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 15:22:28 -0400
Received: from pat.uio.no ([129.240.130.16]:62680 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268089AbUJCTV4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 15:21:56 -0400
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, iwamoto@valinux.co.jp,
       haveblue@us.ibm.com, Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       piggin@cyberone.com.au, arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041004.033559.71092746.taka@valinux.co.jp>
References: <20041002183349.GA7986@logos.cnet>
	 <20041003.131338.41636688.taka@valinux.co.jp>
	 <20041003140723.GD4635@logos.cnet>
	 <20041004.033559.71092746.taka@valinux.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096831287.9667.61.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 21:21:27 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 03/10/2004 klokka 20:35, skreiv Hirokazu Takahashi:

> Pages for NFS also might be pinned with network problems.
> One of the ideas is to restrict NFS to allocate pages from
> specific memory region, sot that all memory except the region
> can be hot-removed. And it's possible to implementing whole
> migrate_page method, which may handled stuck pages.

Why do you want to special-case this?

The above is a generic condition: any filesystem can suffer from the
equivalent problem of a failure or slow response in the underlying
device. Making an NFS-specific hack is just counter-productive to
solving the generic problem.

Cheers,
  Trond


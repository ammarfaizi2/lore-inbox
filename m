Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVLGPmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVLGPmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVLGPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:42:14 -0500
Received: from pat.uio.no ([129.240.130.16]:22242 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751139AbVLGPmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:42:14 -0500
Subject: Re: another nfs puzzle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4397011E.9010703@redhat.com>
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
	 <4396EB2F.3060404@redhat.com>
	 <1133964667.27373.13.camel@lade.trondhjem.org> <4396EF50.30201@redhat.com>
	 <1133966063.27373.29.camel@lade.trondhjem.org>
	 <4397011E.9010703@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 10:41:57 -0500
Message-Id: <1133970117.27373.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.715, required 12,
	autolearn=disabled, AWL 1.10, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 10:34 -0500, Peter Staubach wrote:

> This seems like a dangerous enough area that denying mmap on a file which
> has been opened with O_DIRECT by any process and denying open(O_DIRECT)
> on a file which has been mmap'd would be a good thing.  These things are
> easy enough to keep track of, so it shouldn't be too hard to implement.

That would be a recipe for DOSes as it would allow one process to block
another just by opening a file. I'd really not like to see my database
crash just because some obscure monitoring program happens to use mmap()
to browse the file.

Cheers,
  Trond


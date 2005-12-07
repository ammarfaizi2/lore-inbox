Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVLGOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVLGOew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVLGOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:34:52 -0500
Received: from pat.uio.no ([129.240.130.16]:55001 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751104AbVLGOev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:34:51 -0500
Subject: Re: another nfs puzzle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4396EF50.30201@redhat.com>
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
	 <4396EB2F.3060404@redhat.com>
	 <1133964667.27373.13.camel@lade.trondhjem.org>  <4396EF50.30201@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 09:34:22 -0500
Message-Id: <1133966063.27373.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.076, required 12,
	autolearn=disabled, AWL 1.74, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 09:18 -0500, Peter Staubach wrote:
> >In this context it doesn't matter whether or not the you use the same
> >file descriptor. The problem is the same if my process opens the file
> >for O_DIRECT and then your process open it for normal I/O, and mmaps it.
> >
> 
> Yup, same problem.  Why is this allowed?  Does it really work correctly?

Assuming that the processes have _some_ method of synchronisation, then
I cannot see why it shouldn't be workable. Come to think of it, it might
even be possible to use O_DIRECT to provide that synchronisation (use
O_DIRECT to set a "lock" on the page, then modify it using mmap). 

Whether or not there are people out there that actually _want_ to do
this is a different matter.

Cheers,
  Trond


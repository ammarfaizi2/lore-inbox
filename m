Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVCaACs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVCaACs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCaACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:02:48 -0500
Received: from pat.uio.no ([129.240.130.16]:20928 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262603AbVCaACp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:02:45 -0500
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050330154444.02da9765.akpm@osdl.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	 <20050330143409.04f48431.akpm@osdl.org>
	 <1112224663.18019.39.camel@lade.trondhjem.org>
	 <20050330154444.02da9765.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 19:02:34 -0500
Message-Id: <1112227354.10672.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.492, required 12,
	autolearn=disabled, AWL 1.46, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 30.03.2005 Klokka 15:44 (-0800) skreiv Andrew Morton:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > This is required in order to allow threads such as rpciod or keventd
> > itself (for which sleeping may cause deadlocks) to ask the iosem manager
> > code to simply queue the work that need to run once the iosem has been
> > granted. That work function is then, of course, responsible for
> > releasing the iosem when it is done.
> 
> I see.  I think.  Should we be using those aio/N threads for this?  They
> don't seem to do much else...

That would be quite OK by me if nobody objects.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


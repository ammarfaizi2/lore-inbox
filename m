Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbTEDSeY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTEDSeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:34:23 -0400
Received: from pat.uio.no ([129.240.130.16]:19659 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261544AbTEDSeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:34:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16053.24599.277205.64363@charged.uio.no>
Date: Sun, 4 May 2003 20:46:47 +0200
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
In-Reply-To: <20030504203655.A11574@lst.de>
References: <20030504191447.C10659@lst.de>
	<16053.20430.903508.188812@charged.uio.no>
	<20030504203655.A11574@lst.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@lst.de> writes:

     > On Sun, May 04, 2003 at 07:37:18PM +0200, Trond Myklebust
     > wrote:
    >> There's another case which you appear to be ignoring:
    >> rpciod_down() is interruptible and does not have to wait on the
    >> rpciod() thread to complete.

     > What do you thing about something like the following to wait on
     > the thread in module_exit()?

I don't understand. That is still an interruptible wait, so how would
that help?

What is wrong with just assuming that the rpciod() thread might need
to run independently of the calling module for a short period of time
in order to kill/clean up the pending tasks?

Cheers,
  Trond

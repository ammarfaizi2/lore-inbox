Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbTGIShc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbTGIShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:37:32 -0400
Received: from pat.uio.no ([129.240.130.16]:8170 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266092AbTGISgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:36:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16140.25619.963866.474510@charged.uio.no>
Date: Wed, 9 Jul 2003 20:50:59 +0200
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
In-Reply-To: <200307092041.42608.m.c.p@wolk-project.de>
References: <20030709133109.A23587@infradead.org>
	<Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
	<16140.24595.438954.609504@charged.uio.no>
	<200307092041.42608.m.c.p@wolk-project.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

     > err, -aa has XFS per default, -wolk has XFS per default. So
     > ... ;)

So they have both XFS + NFS O_DIRECT?

The answer to your question is then that somebody made the trivial
conversion on XFS... It's just a question of replacing the second
argument of the direct_IO() method with a filp, then extracting the
inode from that. A 2-liner patch at most...

The point here is that Marcelo's tree does not include XFS, so my
patch can't fix it up...
As I said, I suggest replacing KERNEL_HAS_O_DIRECT with
KERNEL_HAS_O_DIRECT2 so that the XFS patches can switch on that, and
hence provide the 2-liner on newer kernels...

Cheers,
  Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbTFRSTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTFRSTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:19:39 -0400
Received: from pat.uio.no ([129.240.130.16]:56527 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265438AbTFRSTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:19:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.45129.596389.443522@charged.uio.no>
Date: Wed, 18 Jun 2003 11:32:41 -0700
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Support non reserved ports for NFS client
In-Reply-To: <20030618145145.GA5204@wotan.suse.de>
References: <20030618145145.GA5204@wotan.suse.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andi Kleen <ak@suse.de> writes:

     > Currently you cannot have more than 1024 mounts for a single
     > local IP address because the NFS client always tries to get a
     > "secure" port <1024.

     > This patch adds a new noreserved mount option to disable this.

Hi Andi,

  I've already got a patch to accomplish most of this in

  http://www.fys.uio.no/~trondmy/src/2.4.21/linux-2.4.21-11-fix_tcprace3.dif

It's a backport of some patches that have already gone into 2.5.x to
fix some TCP client reconnection issues. I was hoping to push these
patches to Marcelo for 2.4.22.

Could you therefore please just send me a patch for the
NFS_MOUNT_NONRESERVED mount option alone. Then I'll append it to this
patch series?

This should also make it easy to port the whole thing forward to 2.5.x
(although please note that for 2.5.x I'm also planning some other
improvements that will allow us to share the struct xprt between
different RPC clients).

Cheers,
  Trond

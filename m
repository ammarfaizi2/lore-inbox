Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbTFLPVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbTFLPVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:21:42 -0400
Received: from pat.uio.no ([129.240.130.16]:30956 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264860AbTFLPVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:21:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.40370.828325.379995@charged.uio.no>
Date: Thu, 12 Jun 2003 08:35:14 -0700
To: dipankar@in.ibm.com
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <20030612135254.GA2482@in.ibm.com>
References: <20030612125630.GA19842@butterfly.hjsoft.com>
	<20030612135254.GA2482@in.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dipankar Sarma <dipankar@in.ibm.com> writes:

     > I am not supprised at all by this, I can see two csets in
     > Linus' tree that will definitely break dcache -

     > 1. http://linux.bkbits.net:8080/linux-2.5/cset@1.1215.104.2?nav=index.html|ChangeSet@-2d

     > __d_drop() *must not* initialize d_hash fields. Lockfree lookup
     > depends on that. If __d_drop() needs to be allowed on an
     > unhashed dentry, the right thing to do would be to check for
     > DCACHE_UNHASHED before unhashing. I will submit a patch a
     > little later to do this.

Can you please remind us exactly what the benefits of all this are? 
Why can't d_free() immediately free the memory instead of relying on
the RCU mechanism?

Cheers,
  Trond

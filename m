Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTJWVzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJWVzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:55:49 -0400
Received: from pat.uio.no ([129.240.130.16]:4501 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261824AbTJWVzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:55:48 -0400
To: Andre Tomt <andre@tomt.net>
Cc: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
	<20031023181251.GA5490@titan.lahn.de>
	<1066944036.4293.103.camel@slurv>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Oct 2003 16:55:42 -0500
In-Reply-To: <1066944036.4293.103.camel@slurv>
Message-ID: <shsllrb1uw1.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andre Tomt <andre@tomt.net> writes:

     > Did you patch your source with
     > ea+acl+nfsacl-2.4.22-0.8.63.diff.gz?  vanilla -pre8 looks fine,
     > however a strikingly similar hunk is in the ea+acl+nfsacl
     > patch:


     > It looks safe to just nuke this hunk from the acl patch.

Indeed. It would appear to be quite incorrect to return ENOSYS in this
case, since glibc tends to interpret that as meaning that an actual
syscall is not implemented.

     > NB: Always test a clean kernel tree ;-)

Right... Or else report bugs to the maintainers of the patches you
have applied rather than to me.

Cheers,
  Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTFKReD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFKReB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:34:01 -0400
Received: from pat.uio.no ([129.240.130.16]:12518 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263298AbTFKRdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:33:54 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Frank Cusack <fcusack@fcusack.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
	<1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk>
	<16103.26865.361044.360120@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Jun 2003 19:47:24 +0200
In-Reply-To: <16103.26865.361044.360120@charged.uio.no>
Message-ID: <shsn0goy09f.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > 2.4 has the 'return ESTALE if current dir fails d_revalidate()'
     > test. Looks like the vfat stuff has the same problem that

I should learn to complete my own sentences before sending... The
above should read:

Looks like the vfat stuff has the same problem that Coda did. It is
unintentionally triggering the ESTALE code, as it assumes that
d_revalidate() is advisory only.

Cheers,
  Trond

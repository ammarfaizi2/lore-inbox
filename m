Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTKNOnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTKNOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:43:19 -0500
Received: from pat.uio.no ([129.240.130.16]:61679 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262747AbTKNOnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:43:18 -0500
To: Philippe Gramoull~ <philippe.gramoulle@mmania.com>
Cc: nfs <nfs@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [NFS] 2.4.21 - Oops in rpciod
References: <20031114121005.5dceb59a.philippe.gramoulle@mmania.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Nov 2003 09:27:03 -0500
In-Reply-To: <20031114121005.5dceb59a.philippe.gramoulle@mmania.com>
Message-ID: <shs3ccr6n60.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Philippe Gramoull <Philippe> writes:

     >  Hi,

     > I happened to get this oops with a 2.4.21 (Dell 2650) running
     > as an NFS server.  The exported partition is ~ 700Gb/reiserfs
     > and was 99.99% full (only few dozens of megabytes left).
     > (Distro is Debian Sid/Unstable, RAID driver is megaraid.o v
     > 2.00.5)

Looks like something prematurely deleted the nlm_block. AFAICS that
can only happen if something is accessing the nlm_blocked list without
holding the BKL, or is failing to respect the b_incall flag.

Cheers,
  Trond

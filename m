Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSFDFmm>; Tue, 4 Jun 2002 01:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSFDFml>; Tue, 4 Jun 2002 01:42:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316339AbSFDFml>;
	Tue, 4 Jun 2002 01:42:41 -0400
Date: Mon, 03 Jun 2002 21:37:43 -0700 (PDT)
Message-Id: <20020603.213743.68155795.davem@redhat.com>
To: dmj+@andrew.cmu.edu
Cc: ppadala@cise.ufl.edu, linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020529234951.GA3797@branoic.them.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
   Date: Wed, 29 May 2002 19:49:51 -0400
   
   Not really, we should just get EINVAL (ENOSYS?) back when we try to use
   it, right?
   
I answered this last week, you will get -EIO which turns out to also a
valid return from PTRACE_READDATA.  So a backwards compatible way to
test for existence of PTRACE_READDATA is going to be difficult.

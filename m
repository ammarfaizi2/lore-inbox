Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSE3Aqy>; Wed, 29 May 2002 20:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315980AbSE3Aqx>; Wed, 29 May 2002 20:46:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25010 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315946AbSE3Aqw>;
	Wed, 29 May 2002 20:46:52 -0400
Date: Wed, 29 May 2002 17:31:18 -0700 (PDT)
Message-Id: <20020529.173118.130757558.davem@redhat.com>
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

   On Sun, May 19, 2002 at 09:40:53PM -0700, David S. Miller wrote:
   > If other platforms added PTRACE_READDATA support, they would
   > also need to add some way to do a feature test for it's presence
   > so that GDB and other debugging code could actually make use
   > of it portably.
   
   Not really, we should just get EINVAL (ENOSYS?) back when we try to use
   it, right?

You'd get -EIO, but otherwise yes you are right.

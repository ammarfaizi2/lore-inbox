Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277206AbRJLESv>; Fri, 12 Oct 2001 00:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277207AbRJLESl>; Fri, 12 Oct 2001 00:18:41 -0400
Received: from [202.135.142.195] ([202.135.142.195]:37134 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S277206AbRJLES0>; Fri, 12 Oct 2001 00:18:26 -0400
Date: Fri, 12 Oct 2001 14:14:19 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Paul E. McKenney" <mckenney@eng4.beaverton.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-Id: <20011012141419.4ea534b5.rusty@rustcorp.com.au>
In-Reply-To: <Pine.PTX.3.91.1011010185252.9717A-300000@eng4.beaverton.ibm.com>
In-Reply-To: <Pine.PTX.3.91.1011010185252.9717A-300000@eng4.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 18:56:26 -0700 (PDT)
"Paul E. McKenney" <mckenney@eng4.beaverton.ibm.com> wrote:
 
> Here are two patches.  The wmbdd patch has been modified to use
> the lighter-weight SPARC instruction, as suggested by Dave Miller.
> The rmbdd patch defines an rmbdd() primitive that is defined to be
> rmb() on Alpha and a nop on other architectures.  I believe this
> rmbdd() primitive is what Richard is looking for.

Surely we don't need both?  If rmbdd exists, any code needing wmbdd
is terminally broken?

Rusty.

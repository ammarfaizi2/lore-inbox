Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTCBVxj>; Sun, 2 Mar 2003 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTCBVxj>; Sun, 2 Mar 2003 16:53:39 -0500
Received: from are.twiddle.net ([64.81.246.98]:37030 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261451AbTCBVxi>;
	Sun, 2 Mar 2003 16:53:38 -0500
Date: Sun, 2 Mar 2003 14:03:25 -0800
From: Richard Henderson <rth@twiddle.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Norbert Kiesel <nkiesel@tbdnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
Message-ID: <20030302140325.A32479@twiddle.net>
Mail-Followup-To: Werner Almesberger <wa@almesberger.net>,
	Ulrich Drepper <drepper@redhat.com>,
	Norbert Kiesel <nkiesel@tbdnetworks.com>,
	linux-kernel@vger.kernel.org
References: <20030302121425.GA27040@defiant> <3E6247F7.8060301@redhat.com> <20030302184114.Q2791@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030302184114.Q2791@almesberger.net>; from wa@almesberger.net on Sun, Mar 02, 2003 at 06:41:14PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 06:41:14PM -0300, Werner Almesberger wrote:
> While I agree with your observation in general, this is actually
> something the compiler should be able to figure out by itself:
> 
>  - there's only a side-effect if acm is NULL

In general there's also a side effect if acm is uninitialized.
I didn't look at the code in question here.

As for the rest, it's true that we should be able to do this,
but we don't currently have a pass that globally propagates
"trapiness" of memory references.  It would be a useful thing
to have though, particularly for Java, which is required to
arrange for these traps to be able to be caught with exceptions,
and other horrible reordering issues.


r~

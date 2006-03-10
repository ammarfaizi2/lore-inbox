Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752195AbWCJXkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbWCJXkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbWCJXkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:40:15 -0500
Received: from nevyn.them.org ([66.93.172.17]:29155 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1752195AbWCJXkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:40:13 -0500
Date: Fri, 10 Mar 2006 18:40:10 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: dkegel <dkegel@google.com>
Cc: Andrew Morton <akpm@osdl.org>, Markus Gutschke <markus@google.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on i386
Message-ID: <20060310234010.GA6549@nevyn.them.org>
Mail-Followup-To: dkegel <dkegel@google.com>, Andrew Morton <akpm@osdl.org>,
	Markus Gutschke <markus@google.com>, linux-kernel@vger.kernel.org
References: <4410BB32.1020905@google.com> <20060309184759.591e3551.akpm@osdl.org> <4410EC8A.4020808@google.com> <20060309192232.2fd4767c.akpm@osdl.org> <545d88bc0603091936i5c25c065ne8e31ca23e9473f4@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545d88bc0603091936i5c25c065ne8e31ca23e9473f4@mail.google.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 07:36:25PM -0800, dkegel wrote:
> On 3/9/06, Andrew Morton <akpm@osdl.org> wrote:
> > I doubt if glibc is borrowing the kernel's macros.
> 
> I think it is, though.
> 
> When I build gcc/glibc toolchains, I have to use kernel headers.
> I used to directly use the ones in the kernel.org tree, but
> those aren't quite intended for use in userspace; fortunately,
> Mariusz Mazur's sanitized kernel headers work great.
> 
> I'd like to see these patches go in to the sanitized kernel headers
> and/or the kernel.org tree.  I imagine that putting them in the kernel.org
> tree is right, and they'd naturally percolate from there to the
> various sanitized headers projects.

It uses the headers for many things.  It does not use the _syscallX
macros.

-- 
Daniel Jacobowitz
CodeSourcery
